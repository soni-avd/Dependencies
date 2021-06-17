//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Сони Авдеева on 08/01/2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import SnapKit
import iOSIntPackage

class ProfileViewController: UIViewController {
    
        lazy var profileTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        #if DEBUG
        tv.backgroundColor = .cyan
        #else
        tv.backgroundColor = .lightGray
        #endif
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(ProfileTableViewCell.self, forCellReuseIdentifier: String(describing: ProfileTableViewCell.self))
        tv.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tv.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileHeaderView.self))
        tv.isUserInteractionEnabled = true
        return tv
    }()
    var transparentView: UIView = {
        let tv = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isUserInteractionEnabled = true
        tv.alpha = 0
        return tv
    }()
    
    let hv = ProfileHeaderView()
    
    let buttonX: UIButton = {
        let x = UIButton(type: .close)
        x.isUserInteractionEnabled = true
        x.translatesAutoresizingMaskIntoConstraints = false
        x.addTarget(self, action: #selector(closeAnimation), for: .touchUpInside)
        x.alpha = 0
        return x
    }()
    var avatarFullScreen: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "major.jpg")
        image.layer.cornerRadius = 60
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 3
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.alpha = 0
        return image
    }()
    var currentAnimation = 0
    
    var userService: UserService
    var userName: String
    var user: User?
    
    init(userService: UserService, userName: String) {
        #if DEBUG
        self.userService = TestUserService()
        #else
        self.userService = CurrentService()
        #endif
        self.userName = userName
        hv.profileImage.image = userService.avatar
        hv.profileTitle.text = userService.fullName
        hv.profileInfo.text = userService.status
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
            super.viewDidLoad()
        view.addSubview(profileTableView)
        view.addSubview(transparentView)
        view.addSubview(buttonX)
        navigationController?.isNavigationBarHidden = true
        
        avatarFullScreen.frame = .init(x: view.safeAreaInsets.top + 16, y: view.safeAreaInsets.right + 30, width: 120, height: 120)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        hv.addGestureRecognizer(tapGesture)
        
        profileTableView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.trailing.equalTo(view)
            make.leading.equalTo(view)
        }
        transparentView.snp.makeConstraints { make in
            make.bottom.equalTo(profileTableView)
            make.top.equalTo(profileTableView)
            make.trailing.equalTo(profileTableView)
            make.leading.equalTo(profileTableView)
        }
        buttonX.snp.makeConstraints { make in
            make.top.equalTo(transparentView.safeAreaLayoutGuide).inset(15)
            make.trailing.equalTo(transparentView.safeAreaLayoutGuide).inset(15)
            make.width.height.equalTo(15)
}
    }
    @objc func closeAnimation() {
        print(#function)
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3 / 0.8) {
                self.buttonX.alpha = 0
                
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5 / 0.8) {
                //                self.hv.profileImage.transform = .identity
                self.transparentView.alpha = 0
                self.avatarFullScreen.layer.cornerRadius = 60
                self.avatarFullScreen.frame = .init(x: self.view.safeAreaInsets.top + 16, y: self.view.safeAreaInsets.right + 30, width: 120, height: 120)
                self.avatarFullScreen.alpha = 0
            }
        }, completion: { finished in
            print(finished)
        })
    }
    
    @objc func tap() {
        print(#function)
        currentAnimation += 1
        if currentAnimation > 7 {
            currentAnimation = 0
        }
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: .calculationModeLinear, animations: {
            self.view.addSubview(self.avatarFullScreen)
            switch self.currentAnimation {
            case 1: UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5 / 0.8) {
                self.transparentView.backgroundColor = .white
                self.transparentView.alpha = 0.5
                self.avatarFullScreen.alpha = 1
                                self.avatarFullScreen.frame = .init(origin: .init(
                                                    x: self.view.bounds.minX,
                                                    y: self.view.bounds.midY - self.avatarFullScreen.bounds.height),
                                                   size: .init(width: self.view.bounds.width,
                                                               height: self.view.bounds.height / 2))
                
                self.avatarFullScreen.layer.cornerRadius = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5 / 0.8, relativeDuration: 0.3 / 0.8) {
                self.buttonX.alpha = 1
            }
            default:
                break
            }
            
        }, completion: { finished in
            print(finished)
        })
    }
}
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return hv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 220
        default:
            return .zero
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photosViewController = PhotosViewController()
        navigationController?.pushViewController(photosViewController, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return Storage.tableModel.count
        default:
            break
        }
        return section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self)) as! PhotosTableViewCell
            cell.photoProfile = StoragePhotoProfile.tableModel
            return cell
        } else {
            
            let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileTableViewCell.self), for: indexPath) as! ProfileTableViewCell
            cell.post = Storage.tableModel[indexPath.row]
            return cell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
