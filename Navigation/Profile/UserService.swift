//
//  UserService.swift
//  Navigation
//
//  Created by Сони Авдеева on 7/6/21.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class User {
    var fullName: UILabel
    var avatar: UIImageView
    var status: UILabel

    init(fullname: UILabel, avatar: UIImageView, status: UILabel) {
        self.fullName = fullname
        self.avatar = avatar
        self.status = status
    }
}
protocol UserService {
    func userInformation(_ user: UILabel) -> User
}
class CurrentService: UserService {
    var userInfo: User?
    func userInformation(_ user: UILabel) -> User {
        guard let userInfo = userInfo,
        userInfo.fullName == user else {
            return userInfo!}
        return userInfo
    }

}
 
