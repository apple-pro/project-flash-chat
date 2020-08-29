//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let label = "⚡️FlashChat"

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeLabel(currentIndex: 0)
    }
    
    func writeLabel(currentIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.titleLabel.text = String(self.label.prefix(currentIndex))
            
            if currentIndex < self.label.count {
                self.writeLabel(currentIndex: currentIndex+1)
            }
        }
    }
    

}
