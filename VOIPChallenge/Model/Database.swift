//
//  Database.swift
//  VOIPChallenge
//
//  Created by Jezreel de Oliveira Barbosa on 07/01/20.
//  Copyright © 2020 Eldorado. All rights reserved.
//

import Foundation

class Database {
    // Static Properties
    
    static let didGetAPIInformationNN = Notification.Name("com.eldorado.VOIPChallenge.Database.didGetAPIInformationNN")
    
    static private(set) var profiles: [Profile] = []
    
    // Static Methods
    
    static func getAPI() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            Database.profiles = Database.decodeJSONFile(from: data, to: [Profile].self)
            NotificationCenter.default.post(name: Database.didGetAPIInformationNN, object: nil)
        }
        task.resume()
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
