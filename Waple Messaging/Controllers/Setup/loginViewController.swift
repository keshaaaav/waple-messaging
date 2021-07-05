//
//  loginViewController.swift
//  Waple Messaging
//
//  Created by Keshav Khaneja on 7/5/21.
//

import UIKit

class loginViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 0
        field.layer.borderColor = UIColor.quaternaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        field.placeholder = "Email"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        return field
    }()
    
    private let passField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 0
        field.layer.borderColor = UIColor.quaternaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.isSecureTextEntry = true
        field.leftViewMode = .always
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "Log In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sign Up",
            style: .done,
            target: self,
            action: #selector(didTapSignUp))
        
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        
        emailField.delegate = self
        passField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passField)
        scrollView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width-60
        emailField.frame = CGRect(x: (scrollView.width-size)/2,
                                  y: 20,
                                  width: scrollView.width-60,
                                  height: 52)
        
        passField.frame = CGRect(x: 30,
                                 y: emailField.bottom + 15,
                                 width: scrollView.width-60,
                                 height: 52)
        
        loginButton.frame = CGRect(x: 30,
                                   y: passField.bottom + 15,
                                   width: scrollView.width-60,
                                   height: 52)
    }
    
    @objc private func didTapSignUp() {
        let vc = registerViewController()
        vc.title = "Sign Up"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginButtonTapped() {

        guard let email = emailField.text, let password = passField.text,
              !email.isEmpty,
              !password.isEmpty,
              password.count >= 6
        else {
            alertLoginError()
            return
        }
        
        emailField.resignFirstResponder()
        passField.resignFirstResponder()
    }
    
    func alertLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Make sure you enter the details correctly.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Nevermind", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension loginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passField.becomeFirstResponder()
        }
        if textField == passField {
            loginButtonTapped()
        }
        return true
    }
}
