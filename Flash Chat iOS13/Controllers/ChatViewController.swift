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
        tableView.refreshControl?.addTarget(self, action: #selector(loadMessages), for: UIControl.Event.valueChanged)
        
        loadMessages()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let sender = Auth.auth().currentUser?.email {
            let messages = db.collection(K.FStore.collectionName)
            messages.addDocument(data: [
                K.FStore.fieldNameSender: sender,
                K.FStore.fieldNameBody: messageBody
            ]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    print("Saved Data")
                }
            }
        }
    }
    
    @objc private func loadMessages() {
        messages = []
        
        db.collection(K.FStore.collectionName).getDocuments { (querySnapshot, error) in
            if let snapshotDocs = querySnapshot?.documents {
                self.messages = snapshotDocs.compactMap{ (doc) in
                    
                    let data = doc.data()
                    if let sender = data[K.FStore.fieldNameSender] as? String, let body = data[K.FStore.fieldNameBody] as? String {
                        return Message(id: UUID.init().uuidString, sender: sender, body: body)
                    }
                    
                    return nil
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
        return cell
    }
    
}
