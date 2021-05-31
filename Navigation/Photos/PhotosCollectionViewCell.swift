//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Сони Авдеева on 29/01/2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

class PhotosCollectionViewCell: UICollectionViewCell {
    
    
    var photo: UIImageView = {
        var photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(photo)
        
        let constraints = [
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
