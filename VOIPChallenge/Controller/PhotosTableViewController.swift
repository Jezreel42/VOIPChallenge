//
//  PhotosTableViewController.swift
//  VOIPChallenge
//
//  Created by Jezreel de Oliveira Barbosa on 06/01/20.
//  Copyright © 2020 Eldorado. All rights reserved.
//

import UIKit

class PhotosTableViewController: UIViewController {
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
    
    private var tableView: UITableView {
        return self.view as! UITableView
    }
    
    // Private Methods
    
    private func initView() {
        self.view = UITableView()
        
    }
}
