# URLSession-API-Playgrounds
Playgrounds for URLSession topics

## About
This is a collection of playgrounds that implement some basic `URLSession` methods and networking tasks within a `ViewController`. The topics include:

* HTTP GET requests for JSON data that is then parsed using a struct that conforms to the `Codable` protocol
* HTTP GET requests for binary image data, complete image caching functionality via methods for bumping or updating an `NSCache` object
* HTTP GET requests for binary image data as a `URLSessionDownloadTask`, where the data is stored into a temporary URL and then copied to a local file using `FileManager` 
