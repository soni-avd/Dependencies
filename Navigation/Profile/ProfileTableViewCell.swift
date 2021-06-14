//
//  ProfileTableViewCell.swift
//  Navigation
//
//  Created by Сони Авдеева on 27/01/2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import iOSIntPackage

class ProfileTableViewCell: UITableViewCell {
    
    var post: PostInfo? {
        didSet {
            authorLabel.text = post?.author
            descriptionLabel.text = post?.description
            postImage.image = post?.image
            if let likes = post?.likes {
                postLikes.text = "Likes: " + String(likes)
            }
            if let views = post?.views {
                postViews.text = "Views: " + String(views)
            }
            guard let source = postImage.image else { return }
            if postImage.image == UIImage(named: "john") {
                ImageProcessor().processImage(sourceImage: source, filter: .noir) { [weak self] image in
                self?.postImage.image = image
            }
            } else if postImage.image == UIImage(named: "freddie") {
                ImageProcessor().processImage(sourceImage: source, filter: .monochrome(color: .blue, intensity: 0.5)) { [weak self] image in
                    self?.postImage.image = image
                }
            } else {
                ImageProcessor().processImage(sourceImage: source, filter: .sepia(intensity: 1)) { [weak self] image in
                    self?.postImage.image = image
                }
            }
        }
    }    
    private let authorLabel: UILabel = {
        let author = UILabel()
        author.translatesAutoresizingMaskIntoConstraints = false
        author.font = .systemFont(ofSize: 20, weight: .bold)
        author.textColor = .black
        author.numberOfLines = 1
        return author
    }()
    
    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        description.textColor = .systemGray
        description.numberOfLines = 0
        return description
    }()
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    
    private var postLikes: UILabel = {
        let likes = UILabel()
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.textColor = .black
        return likes
    }()
    
    private let postViews: UILabel = {
        let views = UILabel()
        views.translatesAutoresizingMaskIntoConstraints = false
        views.font = .systemFont(ofSize: 16, weight: .regular)
        views.textColor = .black
        return views
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        [authorLabel, descriptionLabel, postImage, postLikes, postViews].forEach{
            contentView.addSubview($0)
        }
        
        let constraints = [
           
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
            
            
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            authorLabel.heightAnchor.constraint(equalToConstant: 30),
            authorLabel.bottomAnchor.constraint(equalTo: postImage.topAnchor, constant: -12),

           
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLikes.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            postViews.topAnchor.constraint(equalTo: postLikes.topAnchor),
            postViews.leadingAnchor.constraint(equalTo:postLikes.trailingAnchor, constant: 120),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ]
        NSLayoutConstraint.activate(constraints)

    }
    
    
}


