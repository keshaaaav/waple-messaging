//
//  registerViewController.swift
//  Waple Messaging
//
//  Created by Keshav Khaneja on 7/5/21.
//

import UIKit

class registerViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 0
        field.layer.borderColor = UIColor.quaternaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        field.placeholder = "First Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 0
        field.layer.borderColor = UIColor.quaternaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        field.placeholder = "Last Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        return field
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
    
    private let SignupButton: UIButton = {
    
        let button = UIButton()
        button.setTitle("Signup", for: .normal)
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
        title = "Sign Up"
        
        SignupButton.addTarget(self,
                              action: #selector(SignupButtonTapped),
                              for: .touchUpInside)
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passField)
        scrollView.addSubview(SignupButton)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width-60
        firstNameField.frame = CGRect(x: (scrollView.width-size)/2,
                                  y: 20,
                                  width: scrollView.width-60,
                                  height: 52)
        
        lastNameField.frame = CGRect(x: 30,
                                 y: firstNameField.bottom + 15,
                                 width: scrollView.width-60,
                                 height: 52)
        
        emailField.frame = CGRect(x: 30,
                                 y: lastNameField.bottom + 15,
                                 width: scrollView.width-60,
                                 height: 52)
        
        passField.frame = CGRect(x: 30,
                                 y: emailField.bottom + 15,
                                 width: scrollView.width-60,
                                 height: 52)
        
        SignupButton.frame = CGRect(x: 30,
                                   y: passField.bottom + 15,
                                   width: scrollView.width-60,
                                   height: 52)
    }
    
    @objc private func didTapSignUp() {
        let vc = registerViewController()
        vc.title = "Sign Up"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func SignupButtonTapped() {
        
        guard let email = emailField.text, let password = passField.text, let firstName = firstNameField.text, let lastName = lastNameField.text,
            !firstName.isEmpty,
            !lastName.isEmpty,
            !email.isEmpty,
            !password.isEmpty,
            password.count >= 6
        else {
            alertSignupError()
            return
        }
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passField.resignFirstResponder()
    }
    
    func alertSignupError() {
        let alert = UIAlertController(title: "Woops", message: "Make sure you enter the details correctly and the password you choose should be 6 or more characters long.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Alrighty", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension registerViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        }
        if textField == lastNameField {
            emailField.becomeFirstResponder()
        }
        if textField == emailField {
            passField.becomeFirstResponder()
        }
        if textField == passField {
            SignupButtonTapped()
        }
        return true
    }
}
