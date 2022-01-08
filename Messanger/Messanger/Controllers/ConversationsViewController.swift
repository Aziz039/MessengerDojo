//
//  ViewController.swift
//  Messanger
//
//  Created by Abdulaziz Alghamdi on 3/1/2022.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.red
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isLoggedIn()
    }
    
    // check if the user logged in
    // if not go to login page
    private func isLoggedIn() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            print("Not logged in, move to login page")
            let vc = storyboard?.instantiateViewController(withIdentifier: "loginView") as! LoginViewController
            vc.title = "Login"
            self.navigationController?.setViewControllers([vc], animated: true)
        }
    }
}

