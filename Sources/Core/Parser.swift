import Foundation
import Rainbow

public enum Result {
    case success
    case failured
}

open class Parser {

    private let filePath: String
    private let outputBasePath: String

    public init(filePath: String) {
        self.filePath = filePath
        var components = filePath.split(separator: "/", omittingEmptySubsequences: false)
        _ = components.popLast()
        self.outputBasePath = components.joined(separator: "/")
    }

    public func parse() -> Result {

        guard let csvString = readFile(path: filePath) else {
            return .failured
        }

        let regions = createRegions()
        let result = parseCSV(csvString, regions: regions)
        let postcodes = createPostcodes(prefectures: result.0)

        if outputRegions(regions) == .failured {
            return .failured
        }
        if outputPrefectures(result.0) == .failured {
            return .failured
        }
        if outputAreas(result.1) == .failured {
            return .failured
        }
        if outputPostcodes(postcodes) == .failured {
            return .failured
        }
        return .success
    }
}

extension Parser {

    private func readFile(path: String) -> String? {
        let url = URL(fileURLWithPath: path)
        
        guard url.pathExtension == "csv" else {
            logError("CSVファイルのパスが不正です")
            return nil
        }

        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            logError("CSVファイルを読み込めませんでした")
            return nil
        }

        guard let csvString = String(data: data, encoding: .utf8) else {
            logError("CSVファイルを読み込めませんでした")
            return nil
        }

        return csvString
    }

    private func createRegions() -> [Region] {
        let regions = [
            RegionMeta.r1,
            RegionMeta.r2,
            RegionMeta.r3,
            RegionMeta.r4,
            RegionMeta.r5,
            RegionMeta.r6,
            RegionMeta.r7,
            RegionMeta.r8
        ].map {
            Region(meta: $0)
        }
        logInfo("\(regions.count)件の地方データを作成")
        return regions
    }

    private func parseCSV(_ csv: String, regions: [Region]) -> ([Prefecture], [Area]) {
        var lines = csv.components(separatedBy: .newlines)
        _ = lines.removeFirst() // FIXME: 問答無用で1行目はタイトルとして省いてるけど何か指定できるようにしたほうがいいかも

        let rows = lines.map {
            $0.split(separator: ",", omittingEmptySubsequences: false).map { String($0) }
        }

        let prefectures = rows.filter {
            return $0[2] == "1"
        }.map { (row) in
            Prefecture(
                code: row[1],
                regionId: regions.first(where: { (region) -> Bool in
                    return region.hasPrefecture(row[3])
                })?.id ?? 0,
                name: row[3]
            )
        }

        logInfo("\(prefectures.count)件の都道府県データを作成")
        
        let areas = rows.map { (row) in
            Area(
                code: row[0],
                prefectureCode: row[1],
                areaName: row[4],
                cityName: row[5],
                isRep: row[2] == "1"
            )
        }

        logInfo("\(areas.count)件の地域データを作成")

        return (prefectures, areas)
    }

    private func createPostcodes(prefectures: [Prefecture]) -> [Postcode] {
        var postcodes: [Postcode] = []
        for prefecture in prefectures {
            postcodes += prefecture.postcodes.map { (postcode) in
                Postcode(code: postcode, prefectureCode: prefecture.code)
            }
        }
        return postcodes
    }

}

// MARK: - Output
extension Parser {
    private func outputRegions(_ regions: [Region]) -> Result {
        logInfo("地域データの書き出しを開始")
        return outputJson(data: regions, fileName: "regions.json")
    }

    private func outputPrefectures(_ prefectures: [Prefecture]) -> Result {
        logInfo("都道府県データの書き出しを開始")
        return outputJson(data: prefectures, fileName: "prefectures.json")
    }

    private func outputAreas(_ areas: [Area]) -> Result {
        logInfo("地域データの書き出しを開始")
        return outputJson(data: areas, fileName: "areas.json")
    }

    private func outputPostcodes(_ postcodes: [Postcode]) -> Result {
        logInfo("郵便番号データの書き出しを開始")
        return outputJson(data: postcodes, fileName: "postcodes.json")
    }

    private func outputJson<T: Encodable>(data: T, fileName: String) -> Result {

        let jsonData: Data
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            jsonData = try encoder.encode(data)
        } catch {
            logError("jsonにエンコードできませんでした...")
            return .failured
        }

        var url = URL(fileURLWithPath: outputBasePath)
        url.appendPathComponent(fileName)
        logInfo(url.absoluteString)

        do {
            try jsonData.write(to: url)
        } catch {
            print(error)
            logError("jsonファイルの書き込みに失敗しました...")
            return .failured
        }

        return .success

    }
}

// MARK: - ログ系
extension Parser {
    private func logDebug(_ message: String) {
        print(message)
    }

    private func logInfo(_ message: String) {
        print(message.green)
    }

    private func logError(_ message: String) {
        print(message.red)
    }
}