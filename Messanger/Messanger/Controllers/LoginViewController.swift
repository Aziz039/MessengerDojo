//
//  LoginViewController.swift
//  Messanger
//
//  Created by Abdulaziz Alghamdi on 3/1/2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        handleButtonesRoundCorners()
        usernameField.delegate = self
        passwordField.delegate = self
        
    }
    
    // hide tab bar when back from Register
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        handler_login()
    }
    
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        print("move to signup page")
        let vc = storyboard?.instantiateViewController(withIdentifier: "signupView") as! RegisterViewController
        vc.title = "Register"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleButtonesRoundCorners() {
        let cornerRadius: CGFloat = 8
        usernameField.layer.cornerRadius = cornerRadius
        usernameField.layer.masksToBounds = true
        passwordField.layer.cornerRadius = cornerRadius
        passwordField.layer.masksToBounds = true
        signinButton.layer.cornerRadius = cornerRadius
        signinButton.layer.masksToBounds = true
        signupButton.layer.cornerRadius = cornerRadius
        signupButton.layer.masksToBounds = true
    }
    
    func handler_login() {
        guard let email = usernameField.text else {
            showAlert(title: "Error!", message: "Invalid email")
            return
        }
        guard let password = passwordField.text else {
            showAlert(title: "Error!", message: "Invalid password")
            return
        }
        guard !email.isEmpty else {
            showAlert(title: "Error!", message: "Empty email")
            return
        }
        guard !password.isEmpty else {
            showAlert(title: "Error!", message: "Empty password")
            return
        }
        print("Logging in..")
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            handler_login()
        }
        return true
    }
    
}
