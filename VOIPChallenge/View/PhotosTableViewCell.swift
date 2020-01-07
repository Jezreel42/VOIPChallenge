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
    static let rowHeight: CGFloat = 116.0
    
    // Public Types
    // Public Properties
    // Public Methods
    
    func fill(with profile: Profile) {
        self.profile = profile
        thumbnailImageView.image = profile.thumbnailImage
        titleLabel.text = profile.title
        
        if thumbnailImageView.image == nil {
            NotificationCenter.default.addObserver(self, selector: #selector(thumbnailImageDidDownloaded), name: Profile.thumbnailImageDownloadedNN, object: profile)
        }
    }
    
    // Initialisation/Lifecycle Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    
    override func prepareForReuse() {
        NotificationCenter.default.removeObserver(self)
        thumbnailImageView.image = nil
        titleLabel.text = nil
        profile = nil
    }
    
    // Private Types
    // Private Properties
    
    private weak var profile: Profile?
    
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    
    // Private Methods
    
    @objc private func thumbnailImageDidDownloaded() {
        DispatchQueue.main.async {
            self.thumbnailImageView.image = self.profile?.thumbnailImage
        }
    }
    
    private func renderSuperView() {
        sv(
            thumbnailImageView,
            titleLabel
        )
    }
    
    private func renderLayout() {
        thumbnailImageView.size(100).centerVertically().left(16)
        titleLabel.Left == thumbnailImageView.Right + 16
        titleLabel.Top == thumbnailImageView.Top
        titleLabel.right(16)
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.selectionStyle = .none
        }
        titleLabel.style { (s) in
            s.numberOfLines = 0
        }
    }
}
