//
//  PhotosTableViewCell.swift
//  VOIPChallenge
//
//  Created by Jezreel de Oliveira Barbosa on 07/01/20.
//  Copyright © 2020 Eldorado. All rights reserved.
//

import UIKit
import Stevia

class PhotosTableViewCell: UITableViewCell {
    // Static properties
    
    static let reuseIdentifier: String = "PhotosTableViewCell"
    static let rowHeight: CGFloat = 166.0
    
    // Public Types
    // Public Properties
    // Public Methods
    
    func fill(with profile: Profile) {
        thumbnailImageView.image = profile.thumbnailImage
        titleLabel.text = profile.title
    }
    
    // Initialisation/Lifecycle Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    
    // Private Methods
    
    private func renderSuperView() {
        sv(
            thumbnailImageView,
            titleLabel
        )
    }
    
    private func renderLayout() {
        thumbnailImageView.size(150).centerVertically().left(16)
        titleLabel.Left == thumbnailImageView.Right + 16
        titleLabel.Top == thumbnailImageView.Top
        titleLabel.right(16)
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        titleLabel.style { (s) in
            s.numberOfLines = 0
        }
    }
}
