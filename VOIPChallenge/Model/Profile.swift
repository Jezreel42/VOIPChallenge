//
//  Profile.swift
//  VOIPChallenge
//
//  Created by Jezreel de Oliveira Barbosa on 07/01/20.
//  Copyright © 2020 Eldorado. All rights reserved.
//

import UIKit

class Profile: Decodable {
    // Static Properties
    
    static let photoImageDownloadedNN = Notification.Name("com.eldorado.VOIPChallenge.Profile.photoImageDownloadedNN")
    static let thumbnailImageDownloadedNN = Notification.Name("com.eldorado.VOIPChallenge.Profile.thumbnailImageDownloadedNN")
    
    // Static Methods
    // Public Types
    // Public Properties
    
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
    
    private(set) var photoImage: UIImage? = nil
    private(set) var thumbnailImage: UIImage? = nil
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        albumId = try container.decode(Int.self, forKey: .albumId)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        let urlString = try container.decode(String.self, forKey: .url)
        url = URL(string: urlString)!
        let thumbnailUrlString = try container.decode(String.self, forKey: .thumbnailUrl)
        thumbnailUrl = URL(string: thumbnailUrlString)!
        
//        fetchImages()
    }
    
    // Override Methods
    // Private Types
    
    private enum CodingKeys: String, CodingKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
    
    // Private Properties
    // Private Methods
    
    private func fetchImages() {
        if self.photoImage == nil {
            let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else { return }
                self.photoImage = UIImage(data: data, scale: UIScreen.main.scale)
                NotificationCenter.default.post(name: Profile.photoImageDownloadedNN, object: self)
            }
            task.resume()
        }
        if self.thumbnailImage == nil {
            let task = URLSession(configuration: .default).dataTask(with: thumbnailUrl) { (data, response, error) in
                guard let data = data, error == nil else { return }
                self.thumbnailImage = UIImage(data: data, scale: UIScreen.main.scale)
                NotificationCenter.default.post(name: Profile.photoImageDownloadedNN, object: self)
            }
            task.resume()
        }
    }
}
