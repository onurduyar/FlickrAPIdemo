# FlickrAPIdemo

This project was developed just to make requests to any API and put the data from the API into the appropriate Data Model.<p>
Only "URLSession" was used when make request to API.
I used [Flickr API](https://www.flickr.com/services/api/).

<img src="https://github.com/onurduyar/FlickrAPIdemo/blob/main/demo.png" alt="drawing" width="300"/>

### URL into UIImageView

```swift

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
```

### Model Class

```swift

class Photo: Codable {
    let photoID: String
    let title: String
    let remoteURL: URL
    let dateTaken: Date
    
    // MARK: JSON MAPPING
    
    enum CodingKeys: String, CodingKey {
        case title
        case photoID = "id"
        case remoteURL = "url_z"
        case dateTaken = "datetaken"
    }
}

```

### Sample URL

```swift

let url = "https://www.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=***********&extras=date_taken,owner_name,url_z&format=json&nojsoncallback=1"

```

