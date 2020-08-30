//
//  Message.swift
//  Flash Chat iOS13
//
//  Created by StartupBuilder.INFO on 8/30/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

struct Message: Identifiable {
    let id: String
    let sender: String
    let body: String
}
