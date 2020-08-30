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
    
    let label = "⚡️FlashChat"

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = label
        //writeLabel(currentIndex: 0)
    }
    
    //deprecated. replaced by CLTypingLabel
    func writeLabel(currentIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.titleLabel.text = String(self.label.prefix(currentIndex))
            
            if currentIndex < self.label.count {
                self.writeLabel(currentIndex: currentIndex+1)
            }
        }
    }
    

}
