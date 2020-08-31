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
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let sender = Auth.auth().currentUser?.email {
            messageTextfield.text = ""
            let messages = db.collection(K.FStore.collectionName)
            messages.addDocument(data: [
                K.FStore.fieldNameSender: sender,
                K.FStore.fieldNameBody: messageBody,
                K.FStore.fieldNameTimestamp: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    print("Saved Data")
                }
            }
        }
    }
    
    private func loadMessages() {
        db.collection(K.FStore.collectionName).order(by: K.FStore.fieldNameTimestamp, descending: false).addSnapshotListener { (querySnapshot, error) in
            if let snapshotDocs = querySnapshot?.documents {
                self.messages = snapshotDocs.compactMap{ (doc) in
                    
                    let data = doc.data()
                    if let sender = data[K.FStore.fieldNameSender] as? String, let body = data[K.FStore.fieldNameBody] as? String {
                        return Message(id: UUID.init().uuidString, sender: sender, body: body)
                    }
                    
                    return nil
                }
                
                DispatchQueue.main.async {
                    let end = IndexPath(row: self.messages.count-1, section: 0)
                    self.tableView.reloadData()
                    self.tableView.scrollToRow(at: end, at: .top, animated: true)
                }
            }
        }
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
        let cell: MessageCell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        let m = messages[indexPath.row]
        cell.messageText?.text = m.body
        
        if let currentUser = Auth.auth().currentUser?.email {
            if m.sender == currentUser {
                cell.messageBubble.backgroundColor = UIColor(named: K.Color.sender)
                cell.senderAvatar.image = #imageLiteral(resourceName: "MeAvatar")
            } else {
                cell.messageBubble.backgroundColor = UIColor(named: K.Color.receiver)
                cell.senderAvatar.image = #imageLiteral(resourceName: "YouAvatar")
            }
        }
        
        return cell
    }
    
}
