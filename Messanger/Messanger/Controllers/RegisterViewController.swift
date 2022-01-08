//
//  RegisterViewController.swift
//  Messanger
//
//  Created by Abdulaziz Alghamdi on 3/1/2022.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // handle tab bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        // setup delegates
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        
        // setup rounded profile image
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = profilePhoto.frame.width / 2.0
        profilePhoto.layer.borderWidth = 2
        profilePhoto.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        handler_signup()
    }
    @IBAction func uploadProfilePage(_ sender: UIButton) {
        showAction()
        print("Uploading profile photo")
    }
    
    func handler_signup() {
        guard let profilePhoto = profilePhoto.image else {
            showAlert(title: "Error!", message: "Invalid profile photo")
            return
        }
        guard let name = nameField.text else {
            showAlert(title: "Error!", message: "Invalid name")
            return
        }
        guard let email = emailField.text else {
            showAlert(title: "Error!", message: "Invalid email")
            return
        }
        guard let password = passwordField.text else {
            showAlert(title: "Error!", message: "Invalid password")
            return
        }
        guard let confirmPassword = confirmPasswordField.text else {
            showAlert(title: "Error!", message: "Invalid confirm password")
            return
        }
        guard !name.isEmpty else {
            showAlert(title: "Error!", message: "Empty name")
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
        guard !confirmPassword.isEmpty else {
            showAlert(title: "Error!", message: "Empty confirm password")
            return
        }
        print("Signing up..")
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            confirmPasswordField.becomeFirstResponder()
        } else if textField == confirmPasswordField {
            handler_signup()
        }
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showAction() {
        let actionSheet = UIAlertController(title: "Select profile photo", message: "Select a method", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: {[weak self]_ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from library", style: .default, handler: {[weak self] _ in
            self?.presentPhotoPicker()
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // test
        picker.dismiss(animated: true, completion: nil)
        print(info)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        profilePhoto.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
