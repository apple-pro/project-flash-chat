//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
        //writeLabel(currentIndex: 0)
    }
    
    //deprecated. replaced by CLTypingLabel
    func writeLabel(currentIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.titleLabel.text = String(K.appName.prefix(currentIndex))
            
            if currentIndex < K.appName.count {
                self.writeLabel(currentIndex: currentIndex+1)
            }
        }
    }
    

}
