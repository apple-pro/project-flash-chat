//
//  SegueExtension.swift
//  Flash Chat iOS13
//
//  Created by StartupBuilder.INFO on 8/30/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func segueToChat() {
        self.performSegue(withIdentifier: "goToChat", sender: self)
    }
}
