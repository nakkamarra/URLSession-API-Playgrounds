//: To test the strain on the system, the file is massive. Probably not best to test on a device using cellular signal instead of wifi.
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        download(from: "https://upload.wikimedia.org/wikipedia/commons/7/74/Earth_poster_large.jpg") { (newPathOfFile) in
            print(newPathOfFile)
        }
    }
    
    /// Function to make a download request to web url, then create file in the system for the data and return its local url.
    ///
    /// - parameters:
    ///     - from: the String value for the web page hosting the data to be downloaded
    ///     - completion: the completion block handler that passes the new file's path
    /// - returns:
    ///     - **URL? path**: the local path to the subsequently stored file holding the data downloaded. Completes with nil if the copy failed.
    
    private func download(from url: String, completion: @escaping (URL?) -> ()) {
        guard let sessionUrl = URL(string: url) else { return }
        let task = URLSession(configuration: .ephemeral).downloadTask(with: sessionUrl) { (path, response, err) in
            guard path != nil, response != nil, err == nil else { return }
            let fileManager = FileManager.default
            do {
                // Uncomment these lines to test load the data into an image
                // let data = try Data(contentsOf: path!)
                // let image = UIImage(data: data)
                var newPath = fileManager.urls(for: .picturesDirectory, in: .userDomainMask)[0]
                newPath.appendPathComponent(sessionUrl.lastPathComponent, isDirectory: false)
                if !fileManager.fileExists(atPath: newPath.absoluteString)
                    && fileManager.fileExists(atPath: path!.absoluteString) {
                    try fileManager.copyItem(at: path!, to: newPath)
                    completion(newPath)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error when copying file: \(error)")
            }

        }
        task.resume()
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
