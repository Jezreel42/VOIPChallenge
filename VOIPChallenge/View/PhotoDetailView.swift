//
//  PhotoDetailView.swift
//  VOIPChallenge
//
//  Created by Jezreel de Oliveira Barbosa on 07/01/20.
//  Copyright © 2020 Eldorado. All rights reserved.
//

import UIKit
import Stevia

class PhotoDetailView: UIView {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    let photoImageView = UIImageView()
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
    
    private func renderSuperView() {
        sv(
            photoImageView
        )
    }
    
    private func renderLayout() {
        photoImageView.fillContainer()
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        photoImageView.style { (s) in
            s.contentMode = .scaleToFill
        }
    }
}
