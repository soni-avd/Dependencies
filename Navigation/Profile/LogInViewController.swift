//
//  LogInViewController.swift
//  Navigation
//
//  Created by Сони Авдеева on 20/01/2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

class LogInViewController: UIViewController {
    
    let logInImage: UIImageView = {
        let logIn = UIImageView()
        logIn.image = UIImage(named: "logo.png")
        logIn.translatesAutoresizingMaskIntoConstraints = false
        return logIn
    }()
    
    let stackLogIn: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.spacing = 0
        stack.layer.masksToBounds = true
        return stack
    }()
    let logInEmail: UITextField = {
        let email = UITextField()
        email.placeholder = "Email or phone"
        email.translatesAutoresizingMaskIntoConstraints = false
        email.backgroundColor = .systemGray6
        email.layer.borderColor = UIColor.lightGray.cgColor
        email.layer.borderWidth = 0.5
        email.leftView = .init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        email.leftViewMode = .always
        email.textColor = .black
        email.font = .systemFont(ofSize: 16)
        return email
    }()
    
    let logInPassword: UITextField = {
        let email = UITextField()
        email.placeholder = "Password"
        email.translatesAutoresizingMaskIntoConstraints = false
        email.backgroundColor = .systemGray6
        email.layer.borderColor = UIColor.lightGray.cgColor
        email.layer.borderWidth = 0.5
        email.isSecureTextEntry = true
        email.textColor = .black
        email.leftView = .init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        email.leftViewMode = .always
        email.font = .systemFont(ofSize: 16)
        return email
    }()
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(1), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    var containerView = UIView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func buttonTapped() {
        print("button tapped")
        #if DEBUG
        let userService = TestUserService()
        let userName = userService.fullName
        let profileVC = ProfileViewController(userService: userService, userName: userName)
        self.navigationController?.pushViewController(profileVC, animated: true)
        #else
        let userService = CurrentService()
        let userName = userService.fullName
        let profileVC = ProfileViewController(userService: userService, userName: userName)
        self.navigationController?.pushViewController(profileVC, animated: true)
        #endif
    }
    
    //    MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        [logInImage,stackLogIn,logInButton].forEach{
            containerView.addSubview($0) }
            stackLogIn.addArrangedSubview(logInEmail)
            stackLogIn.addArrangedSubview(logInPassword)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    
    
    override func viewDidLayoutSubviews() {
        
        let constraintants = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logInImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
            logInImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logInImage.heightAnchor.constraint(equalToConstant: 100),
            logInImage.widthAnchor.constraint(equalTo: logInImage.heightAnchor),
            
            stackLogIn.topAnchor.constraint(equalTo: logInImage.bottomAnchor, constant: 120),
            stackLogIn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackLogIn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackLogIn.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.leadingAnchor.constraint(equalTo: stackLogIn.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: stackLogIn.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.topAnchor.constraint(equalTo: stackLogIn.bottomAnchor, constant: 16),
            logInButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24)
        ]
        NSLayoutConstraint.activate(constraintants)
        
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
