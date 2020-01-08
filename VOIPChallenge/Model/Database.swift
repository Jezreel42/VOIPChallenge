//
//  Database.swift
//  VOIPChallenge
//
//  Created by Jezreel de Oliveira Barbosa on 07/01/20.
//  Copyright © 2020 Eldorado. All rights reserved.
//

import UIKit
import CoreData

class Database {
    // Static Properties
    
    static let didGetAPIInformationNN = Notification.Name("com.eldorado.VOIPChallenge.Database.didGetAPIInformationNN")
    
    static private(set) var profiles: [Profile] = []
    
    // Static Methods
    
    static func getAPI() {
        if let resource = Database.getAPIResource() {
            Database.profiles = Database.decodeJSONFile(from: resource, to: [Profile].self)
            NotificationCenter.default.post(name: Database.didGetAPIInformationNN, object: nil)
        }
        else {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
            let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                guard let resource = data, error == nil else { return }
                Database.profiles = Database.decodeJSONFile(from: resource, to: [Profile].self)
                NotificationCenter.default.post(name: Database.didGetAPIInformationNN, object: nil)
                Database.saveAPIResource(resource: resource)
            }
            task.resume()
        }
    }
    
    static private func decodeJSONFile<T>(from jsonResource: Data, to type: [T].Type) -> [T] where T: Decodable {
        if let decoded = try? JSONDecoder().decode(type, from: jsonResource) {
            return decoded
        }
        else {
            print("Decode from json error")
            return []
        }
    }
    
    static private func saveAPIResource(resource: Data) {
        DispatchQueue.main.async {
            guard
                let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext,
                let entity = NSEntityDescription.entity(forEntityName: "APIEntity", in: context)
            else { return }
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "APIEntity")
            
            do {
                if let api = try context.fetch(request).first {
                    api.setValue(resource, forKey: "resource")
                }
                else {
                    let api = NSManagedObject(entity: entity, insertInto: context)
                    api.setValue(resource, forKey: "resource")
                }
                
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    static private func getAPIResource() -> Data? {
        guard
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        else { return nil }
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "APIEntity")
        
        do {
            if let profile = try context.fetch(request).first, let resource = profile.value(forKey: "resource") as? Data {
                return resource
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    private init() {
        
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
}
