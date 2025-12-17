//
//  LoginViewController.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 16/12/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var eyeButton: UIButton!
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
        eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        // 2. Set the target action
            eyeButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
            
            // 3. Assign the button to the RIGHT VIEW of the text field
            passwordTextField.rightView = eyeButton
            passwordTextField.rightViewMode = .always
        
    }
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry.toggle()
        //confirmPasswordTextField.isSecureTextEntry.toggle()
    }
    


}
