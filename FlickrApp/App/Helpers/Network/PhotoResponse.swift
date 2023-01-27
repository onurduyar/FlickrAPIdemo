//
//  PhotoResponse.swift
//  FlickrApp
//
//  Created by Onur Duyar on 25.01.2023.
//

import Foundation

class PhotoResponse {
    
    private let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    var photos: [Photo] = []
    var error: Error?
    
    func fetchInterestingPhotos(completion: @escaping (Bool) -> ()) {
        let url = FlickerAPI.interestingPhotosURL
        
        let urlRequest = URLRequest(url: url)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            let result = self.processPhotosRequest(data: data, error: error)
            switch result {
            case let .success(photos):
                DispatchQueue.main.async {
                    self.photos = photos
                    completion(true)
                }
               
            case let .failure(error):
                OperationQueue.main.addOperation {
                    self.error = error
                    completion(false)
                }
            }
        }
        task.resume()
    }
    
    private func processPhotosRequest(data: Data?, error: Error?)
    -> Result<[Photo], Error> {
        guard let data else {
            return .failure(error!)
        }
        
        let result = FlickerAPI.photos(fromJSON: data)
        return result
    }
}
