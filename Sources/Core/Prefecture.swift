import Foundation

struct Prefecture: Codable {
    let code: String
    let regionId: Int
    let name: String
}

// ハードコーディングでやっちゃう...その２😇
// https://zekiom.net/programming/prefcode
extension Prefecture {
    var postcodes: [String] {
        switch self.name {
        case "北海道":
            return ["00", "04", "05", "06", "07", "08", "09"]
        case "青森県":
            return ["03"]
        case "岩手県":
            return ["02"]
        case "宮城県":
            return ["98"]
        case "秋田県":
            return ["01"]
        case "山形県":
            return ["99"]
        case "福島県":
            return ["96", "97"]
        case "茨城県":
            return ["30", "31"]
        case "栃木県":
            return ["32"]
        case "群馬県":
            return ["37"]
        case "埼玉県":
            return (33...36).map { String($0) }
        case "千葉県":
            return (26...29).map { String($0) }
        case "東京都":
            return (10...20).map { String($0) }
        case "神奈川県":
            return (21...25).map { String($0) }
        case "新潟県":
            return ["94", "95"]
        case "富山県":
            return ["93"]
        case "石川県":
            return ["92"]
        case "福井県":
            return ["91"]
        case "山梨県":
            return ["40"]
        case "長野県":
            return ["38", "39"]
        case "岐阜県":
            return ["50"]
        case "静岡県":
            return (41...43).map { String($0) }
        case "愛知県":
            return (44...49).map { String($0) }
        case "三重県":
            return ["51"]
        case "滋賀県":
            return ["52"]
        case "京都府":
            return (60...62).map { String($0) }
        case "大阪府":
            return (53...59).map { String($0) }
        case "兵庫県":
            return (65...67).map { String($0) }
        case "奈良県":
            return ["63"]
        case "和歌山県":
            return ["64"]
        case "鳥取県":
            return ["68"]
        case "島根県":
            return ["69"]
        case "岡山県":
            return ["70", "71"]
        case "広島県":
            return ["72", "73"]
        case "山口県":
            return ["74", "75"]
        case "徳島県":
            return ["77"]
        case "香川家":
            return ["76"]
        case "愛媛県":
            return ["79"]
        case "高知県":
            return ["78"]
        case "福岡県":
            return (80...83).map { String($0) }
        case "佐賀県":
            return ["84"]
        case "長崎県":
            return ["85"]
        case "熊本県":
            return ["86"]
        case "大分県":
            return ["87"]
        case "宮崎県":
            return ["88"]
        case "鹿児島県":
            return ["89"]
        case "沖縄県":
            return ["90"]
        default:
            return []
        }
    }
}