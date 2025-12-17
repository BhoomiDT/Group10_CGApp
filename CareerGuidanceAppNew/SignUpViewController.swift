//
//  SignUpViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 15/12/25.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmEyeButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPasswordToggle()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //button1.configuration = nil
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor(hex:"#CAC4D0").cgColor
        button1.layer.cornerRadius = 6
        
        //button2.configuration = nil
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor(hex:"#CAC4D0").cgColor
        button2.layer.cornerRadius = 6
    }
    
    func setUpPasswordToggle() {
        confirmEyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        confirmEyeButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        confirmEyeButton.addTarget(self, action: #selector(confirmTogglePasswordVisibility(_:)), for: .touchUpInside)
        
        confirmPasswordTextField.rightView = confirmEyeButton
        confirmPasswordTextField.rightViewMode = .always
        
        
        eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        // 2. Set the target action
            eyeButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
            
            // 3. Assign the button to the RIGHT VIEW of the text field
            passwordTextField.rightView = eyeButton
            passwordTextField.rightViewMode = .always
        
    }
    func registerUser() {
        guard let username = nameInput.text, !username.isEmpty,
              let email = emailInput.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty
        else {
            showAlert("Error", "All fields are required")
            return
        }
        
        guard password == confirmPassword else {
            showAlert("Error", "Passwords do not match")
            return
        }
        
        let newUser = User(
            username: username,
            email: email,
            password: password,
            confirmPassword: confirmPassword
        )
        
        UserStore.shared.addUser(newUser)
        
        print(UserStore.shared.users) // DEBUG
        
        showAlert("Success", "Registration successful")
    }
    func saveUser(password: String) {
        UserDefaults.standard.set(password, forKey: "userPassword")
        
        showAlert("Success", "User registered successfully")
    }
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry.toggle()
        //confirmPasswordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func confirmTogglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        confirmPasswordTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        registerUser()
    }
}
