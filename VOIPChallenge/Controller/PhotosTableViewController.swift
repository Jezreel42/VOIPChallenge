//
//  PhotosTableViewController.swift
//  VOIPChallenge
//
//  Created by Jezreel de Oliveira Barbosa on 06/01/20.
//  Copyright © 2020 Eldorado. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    let photoDetailViewController = PhotoDetailViewController()
    
    // Private Methods
    
    private func initView() {
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.reuseIdentifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetAPIInformation), name: Database.didGetAPIInformationNN, object: nil)
        Database.getAPI()
    }
    
    @objc private func didGetAPIInformation() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table View Delegate
extension PhotosTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Database.profiles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.reuseIdentifier) as! PhotosTableViewCell
        cell.fill(with: Database.profiles[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PhotosTableViewCell.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        photoDetailViewController.profile = Database.profiles[indexPath.row]
        navigationController?.pushViewController(photoDetailViewController, animated: true)
    }
}
