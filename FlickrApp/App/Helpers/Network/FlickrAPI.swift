//
//  FlickrAPI.swift
//  FlickrApp
//
//  Created by Onur Duyar on 25.01.2023.
//

import Foundation

/*  url = "https://www.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=*********&extras=date_taken,owner_name,url_z&format=json&nojsoncallback=1"
*/

enum Endpoint: String {
    
    case interestingPhotos = "flickr.interestingness.getList"
}

struct FlickerResponse: Codable {
    let photosInfo: FlickerPhotosResponse
    
    enum CodingKeys: String, CodingKey {
        case photosInfo = "photos"
    }
        
}

struct FlickerPhotosResponse: Codable {
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}

struct FlickerAPI {
    
    private static let baseURL = "https://www.flickr.com/services/rest/"
    private static let apiKey = "**************"
        
    private static func flickrURL(endpoint: Endpoint,
                                  parameteres: [String : String]?) -> URL{
        
        var components = URLComponents(string: baseURL)
        
        var queryItems: [URLQueryItem] = []
        
        let baseParams = [
            "format": "json",
            "nojsoncallback": "1",
            "api_key": apiKey,
            "method": endpoint.rawValue
        ]
        
        for (key,value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameteres {
            for (key,value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components?.queryItems = queryItems
        
        return (components?.url)!
    }
    
   static var interestingPhotosURL: URL {
        return flickrURL(endpoint: .interestingPhotos, parameteres: ["extras":
                                                                    "url_z,date_taken,owner_name"])
    }
    static func photos(fromJSON data: Data) -> Result<[Photo], Error > {
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let flickerResponse = try decoder.decode(FlickerResponse.self, from: data)
            return .success(flickerResponse.photosInfo.photos)
            
        } catch {
            return .failure(error)
        }
    }
}
