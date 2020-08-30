//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearError()
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            clearError()
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.errorLabel.text = error!.localizedDescription
                } else {
                    self.performSegue(withIdentifier: "GoToChat", sender: self)
                }
            }
        }
    }
    
    private func clearError() {
        errorLabel.text = ""
    }
    
}
