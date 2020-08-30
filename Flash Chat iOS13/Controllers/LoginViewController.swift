//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearError()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            clearError()
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
              
                if error != nil {
                    self.errorLabel.text = error!.localizedDescription
                } else {
                    self.segueToChat()
                }
            }
        }

    }
    
    private func clearError() {
        errorLabel.text = ""
    }
    
}
