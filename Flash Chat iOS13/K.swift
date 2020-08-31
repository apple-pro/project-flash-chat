//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by StartupBuilder.INFO on 8/30/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

struct K {
    static let appName = "⚡️FlashChat"
    static let segueToChat = "goToChat"
    
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let fieldNameSender = "sender"
        static let fieldNameBody = "body"
    }
}
