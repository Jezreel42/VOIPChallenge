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
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
    
    private func initView() {
        
    }
}

extension PhotosTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "") as! UITableViewCell
        return cell
    }
}
