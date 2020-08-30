//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let messages: [Message] = [
        Message(id: "1", sender: "1@1.com", body: "Hello"),
        Message(id: "1", sender: "1@2.com", body: "Yow"),
        Message(id: "1", sender: "1@3.com", body: "Bitch!"),
        Message(id: "1", sender: "1@1.com", body: "Haha"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }

    @IBAction func logout(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            self.segueToRoot()
        } catch {
            print ("Error signing out: %@", error)
        }
          
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        let m = messages[indexPath.row]
        cell.textLabel?.text = "\(m.sender): \(m.body)"
        return cell
    }
    
    
}
