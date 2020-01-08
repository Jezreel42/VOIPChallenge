//
//  Profile.swift
//  VOIPChallenge
//
//  Created by Jezreel de Oliveira Barbosa on 07/01/20.
//  Copyright © 2020 Eldorado. All rights reserved.
//

import UIKit
import CoreData

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
    
    var photoImage: UIImage? {
        if privatePhotoImage == nil {
            fetchPhotoImage()
        }
        return privatePhotoImage
    }
    var thumbnailImage: UIImage? {
        if privateThumbnailImage == nil {
            fetchThumbnailImage()
        }
        return privateThumbnailImage
    }
    
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
        
        getThumbnailImage()
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
    
    private var privatePhotoImage: UIImage? = nil
    private var privateThumbnailImage: UIImage? = nil
    
    // Private Methods
    
    private func fetchPhotoImage() {
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            self.privatePhotoImage = image
            NotificationCenter.default.post(name: Profile.photoImageDownloadedNN, object: self)
        }
        task.resume()
    }
    private func fetchThumbnailImage() {
        let task = URLSession(configuration: .default).dataTask(with: thumbnailUrl) { (data, response, error) in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            self.privateThumbnailImage = image
            NotificationCenter.default.post(name: Profile.thumbnailImageDownloadedNN, object: self)
            self.saveThumbNailImage()
        }
        task.resume()
    }
    
    private func saveThumbNailImage() {
        DispatchQueue.main.async {
            guard
                let imageData = self.privateThumbnailImage?.pngData(),
                let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext,
                let entity = NSEntityDescription.entity(forEntityName: "ProfileEntity", in: context)
            else { return }
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "ProfileEntity")
            
            do {
                if let profile = try context.fetch(request).first(where: { (object) -> Bool in
                    object.value(forKey: "id") as! Int == self.id
                }) {
                    profile.setValue(imageData, forKey: "thumbnailImage")
                }
                else {
                    let profile = NSManagedObject(entity: entity, insertInto: context)
                    profile.setValue(imageData, forKey: "thumbnailImage")
                    profile.setValue(self.id, forKey: "id")
                }
                
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    private func getThumbnailImage() {
        DispatchQueue.main.async {
            guard
                let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            else { return }
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "ProfileEntity")
            
            do {
                if let profile = try context.fetch(request).first(where: { (object) -> Bool in
                    object.value(forKey: "id") as! Int == self.id
                }), let imageData = profile.value(forKey: "thumbnailImage") as? Data {
                    
                    self.privateThumbnailImage = UIImage(data: imageData)
                }
            }
            catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
}
