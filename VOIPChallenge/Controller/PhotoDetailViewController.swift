//
//  PhotoDetailViewController.swift
//  VOIPChallenge
//
//  Created by Jezreel de Oliveira Barbosa on 07/01/20.
//  Copyright © 2020 Eldorado. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    weak var profile: Profile?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        photoDetailView.photoImageView.image = profile?.photoImage
        if photoDetailView.photoImageView.image == nil {
            NotificationCenter.default.addObserver(self, selector: #selector(photoImageDidDownloaded), name: Profile.photoImageDownloadedNN, object: profile)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        photoDetailView.photoImageView.image = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    // Private Types
    // Private Properties
    
    private var photoDetailView: PhotoDetailView {
        return self.view as! PhotoDetailView
    }
    
    // Private Methods
    
    @objc private func photoImageDidDownloaded() {
        DispatchQueue.main.async {
            self.photoDetailView.photoImageView.image = self.profile?.photoImage
        }
    }
    
    private func initView() {
        self.view = PhotoDetailView()
    }
}
