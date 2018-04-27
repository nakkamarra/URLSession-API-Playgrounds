//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchURL(from: "https://orangevalleycaa.org/api/videos.php")
    }
    
    private func fetchURL(from webPagePath: String) {
        if let url = URL(string: webPagePath) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, err) in
                guard data != nil, err == nil else { return }
                do {
                    let dataString = String(data: data!, encoding: .ascii)
                    let json = try JSONDecoder().decode([[String: String]].self, from: (dataString?.data(using: .ascii))!)
                    print(json)
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
