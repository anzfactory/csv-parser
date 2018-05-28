import Core
import Commander
import Rainbow

let main = command { (path: String) in
    let parser = Parser(filePath: path)
    let result = parser.parse()
    switch result {
    case .success:
        print("処理完了！".blue)
    case .failured:
        print("処理失敗...".red)
    }
}

main.run()