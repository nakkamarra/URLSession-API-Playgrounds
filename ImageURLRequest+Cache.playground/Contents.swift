//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    let imageCache = NSCache<NSString, UIImage>()
    let logoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        logoImage.center = CGPoint(x: 187, y: 333)
        view.addSubview(logoImage)
        
        self.view = view
        fetchImageData(from: "https://media.licdn.com/mpr/mpr/shrink_200_200/AAEAAQAAAAAAAANyAAAAJGRlZTNlZDQwLTk4YTItNDA1MS04MzBjLWJmNGQ5M2RmZGUxYw.png", into: logoImage)
    }
    
    //: Image Data fetch as binary data using URLSession
    func fetchImageData(from url: String, into container: UIImageView) {
        if let image = bumpCache(forKey: url) {
            DispatchQueue.main.async {
                container.image = image
            }
        } else {
            connectForData(url: url, completion: { (image) in
                DispatchQueue.main.async {
                    container.image = image
                }
            })
        }
    }
    
    private func bumpCache(forKey someKey: String) -> UIImage? {
        guard let cachedImage = imageCache.object(forKey: someKey as NSString) else { return nil }
        return cachedImage
    }
    
    private func updateCache(forKey someKey: String, image: UIImage) {
        imageCache.setObject(image, forKey: someKey as NSString)
    }
    
    private func connectForData(url: String, completion: @escaping (UIImage) -> Void) {
        if let connectionURL = URL(string: url) {
            let task = URLSession(configuration: .ephemeral).dataTask(with: connectionURL, completionHandler: { (data, response, error) in
                guard data != nil, error == nil, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { return }
                guard let image = UIImage(data: data!) else { return }
                self.updateCache(forKey: url, image: image)
                completion(image)
            })
            task.resume()
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
