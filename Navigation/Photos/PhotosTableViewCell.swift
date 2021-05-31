//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Сони Авдеева on 28/01/2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

class PhotosTableViewCell: UITableViewCell {
    
    var photoProfile: PhotoProfile? {
        didSet {
            photoLabel.text = photoProfile?.label
            firstPhoto.image = photoProfile?.photo1
            secondPhoto.image = photoProfile?.photo2
            thirdPhoto.image = photoProfile?.photo3
            forthPhoto.image = photoProfile?.photo4
            
        }
    }
    
    let photoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    
    let firstPhoto: UIImageView = {
        let photo = UIImageView()
        photo.clipsToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.layer.cornerRadius = 6
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    let secondPhoto: UIImageView = {
        let photo = UIImageView()
        photo.clipsToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.layer.cornerRadius = 6
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    let thirdPhoto: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    let forthPhoto: UIImageView = {
        let photo = UIImageView()
        photo.clipsToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.layer.cornerRadius = 6
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    let photoStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.contentMode = .scaleAspectFill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let pointer: UIImageView = {
        let pointer = UIImageView()
        pointer.image = UIImage(named: "right-arrow.png")
//        pointer.clipsToBounds = true
        pointer.translatesAutoresizingMaskIntoConstraints = false
        return pointer
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpViews() {
        photoStack.addArrangedSubview(firstPhoto)
        photoStack.addArrangedSubview(secondPhoto)
        photoStack.addArrangedSubview(thirdPhoto)
        photoStack.addArrangedSubview(forthPhoto)
    
        contentView.addSubview(photoLabel)
        contentView.addSubview(photoStack)
        contentView.addSubview(pointer)
        
        let constraints = [
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
          
            photoStack.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            photoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            photoStack.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25, constant: -(8 * 3 + 12 * 2) / 4),
            
            pointer.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            pointer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            pointer.heightAnchor.constraint(equalToConstant: 20),
            pointer.widthAnchor.constraint(equalToConstant: 20)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
}
