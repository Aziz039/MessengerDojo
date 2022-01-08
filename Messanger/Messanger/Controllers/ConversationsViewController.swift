//
//  ViewController.swift
//  Messanger
//
//  Created by Abdulaziz Alghamdi on 3/1/2022.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        isLoggedIn()
        view.backgroundColor = UIColor.red
    }
    
    // check if the user logged in
    // if not go to login page
    func isLoggedIn() {
        let isLogged = UserDefaults.standard.bool(forKey: "loggedIn")
        
        if !isLogged {
            print("Not logged in, move to login page")
            let vc = storyboard?.instantiateViewController(withIdentifier: "loginView") as! LoginViewController
            vc.title = "Login"
            self.navigationController?.setViewControllers([vc], animated: true)
        }
    }


}

