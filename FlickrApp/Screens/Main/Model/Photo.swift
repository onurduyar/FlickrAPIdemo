//
//  Photo.swift
//  FlickrApp
//
//  Created by Onur Duyar on 26.01.2023.
//

import Foundation

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
