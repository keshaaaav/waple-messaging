//
//  ViewController.swift
//  Waple Messaging
//
//  Created by Keshav Khaneja on 7/5/21.
//

import UIKit

class conversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        
        if !isUserLoggedIn {
            let vc = loginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
        
    }
}

