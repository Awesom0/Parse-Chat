//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Felipe De La Torre on 10/12/18.
//  Copyright © 2018 Felipe De La Torre. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var chatMessages: [PFObject] = []
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ChatViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        //tableView.separatorStyle = .none
        retrieveChatMessages()
        onTimer()
        
    }
    
    // send button action
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current() // sets user name
        //print when succefully saved
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                //clears the message label
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
            
        }
    }
    
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        
        retrieveChatMessages()
        
    }
    
    func onTimer(){
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.retrieveChatMessages), userInfo: nil, repeats: true)
        
    }
    
    
    //query
    @objc func retrieveChatMessages() {
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.limit = 20
        query.includeKey("user")
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                self.chatMessages =  messages
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }
    
    // delegate properties
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let chatMessage = chatMessages[indexPath.row]
        // to create bubble view image
        //cell.bubbleView.layer.cornerRadius = 10
        //cell.bubbleView.clipsToBounds = true
        // Sets the chat message
        cell.chatMessageLabel.text = chatMessage["text"] as? String

        // Sets the username
        if let user = chatMessage["user"] as? PFUser {
            cell.userNameLabel.text = user.username
        } else {
            cell.userNameLabel.text = "🤖"
        }
        return cell
    }// end of delegate porperties
    
    
    //log out function
    @IBAction func onLogout(_ sender: Any) {
        print("User Logged out.")
        // manually segue to log in view
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
