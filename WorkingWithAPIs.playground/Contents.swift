//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

struct Product : Codable {
    let id: String
    let name: String
    let imageTitle: String
    let image: URL
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case imageTitle = "image_title"
        case image
    }
}

class MyViewController : UIViewController {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
    
    override func viewDidLoad() {
        loadData()
    }

    
    private let session = URLSession.shared
    private func loadData(){
        guard let url = URL(string: "https://www.hplussport.com/api/products/") else { return }
        let task = session.dataTask(with: url) { (data, response, err) in
            do {
                let dataString = String(data: data!, encoding: .utf8)!
                let jsonData = dataString.data(using: .utf8)!
                let decoder = JSONDecoder()
                let json = try decoder.decode([Product].self, from: jsonData)
                print(json)
            } catch let error as DecodingError {
                print("Decode error: \(error)")
            } catch {
                print("Network Error")
            }
        }
        task.resume()
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
