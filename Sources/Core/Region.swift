import Foundation

// ハードコーディングでがしがしやっちゃう...😇
enum RegionMeta: Int {
    case r1 = 1
    case r2 = 2
    case r3 = 3 
    case r4 = 4 
    case r5 = 5
    case r6 = 6
    case r7 = 7
    case r8 = 8

    var id: Int {
        return self.rawValue
    }

    var name: String {
        switch self {
        case .r1: return "北海道・東北"
        case .r2: return "関東"
        case .r3: return "信越・北陸"
        case .r4: return "東海"
        case .r5: return "近畿"
        case .r6: return "中国"
        case .r7: return "四国"
        case .r8: return "九州・沖縄"
        }
    }

    var prefectures: [String] {
        switch self {
        case .r1:
            return [
                "北海道",
                "青森県",
                "秋田県",
                "岩手県",
                "宮城県",
                "山形県",
                "福島県"
            ]
        case .r2:
            return [
                "茨城県",
                "栃木県",
                "群馬県",
                "埼玉県",
                "東京都",
                "千葉県",
                "神奈川県"
            ]
        case .r3:
            return [
                "長野県",
                "新潟県",
                "富山県",
                "石川県",
                "福井県",
                "山梨県"
            ]
        case .r4:
            return [
                "愛知県",
                "岐阜県",
                "三重県",
                "静岡県"
            ]
        case .r5:
            return [
                "滋賀県",
                "京都府",
                "大阪府",
                "兵庫県",
                "奈良県",
                "和歌山県"
            ]
        case .r6:
            return [
                "岡山県",
                "広島県",
                "鳥取県",
                "島根県",
                "山口県"
            ]
        case .r7:
            return [
                "徳島県",
                "香川県",
                "愛媛県",
                "高知県"
            ]
        case .r8:
            return [
                "福岡県",
                "佐賀県",
                "長崎県",
                "大分県",
                "熊本県",
                "宮崎県",
                "鹿児島県",
                "沖縄県"
            ]
        }
    }

}

struct Region: Codable {
    let id: Int
    let name: String

    init(meta: RegionMeta) {
        self.id = meta.id
        self.name = meta.name
    }
}

extension Region {
    func hasPrefecture(_ prefectureName: String) -> Bool {
        return RegionMeta(rawValue: self.id)?.prefectures.contains(prefectureName) ?? false
    }    
}