//
//  RecentMessagesViewController.swift
//  FireChat
//
//  Created by mohsin raza on 19/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import UIKit
import Firebase
class RecentMessagesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    var chatuserArray = [Users]()
    var messageArray = [Message]()
    var messageDictionary = [String:Message]()
    static var selfobj:RecentMessagesViewController?
    var selectedLabel:Users?
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        chatuserArray.removeAll()
        messageArray.removeAll()
        messageDictionary.removeAll()
        self.observeMsg()
    }
    
    private func observeMsg()
    {
        if let uid = FIRAuth.auth()?.currentUser?.uid
        {
            
        let usersReference = FireService.fireservice.BASE_REF.child("user messages").child(uid)
        usersReference.observe(.childAdded, with:
        {(Snapshot) in
            
            let messageReference = FireService.fireservice.BASE_REF.child("messages").child(Snapshot.key)
            
            messageReference.observeSingleEvent(of:.value, with:
            {(DataSnapshot) in
                
             
                if let dict =  DataSnapshot.value as? [String:String]
                {
                    let message = Message()
                    message.setValuesForKeys(dict)
                    
                    if let toId = message.toid
                    {
                        self.messageDictionary[toId] = message
                        self.messageArray = Array(self.messageDictionary.values)
                        self.messageArray = self.messageArray.sorted
                        {
                                
                            (NumberFormatter().number(from: $0.timestamp!)?.intValue)!
                                                       >
                            (NumberFormatter().number(from: $1.timestamp!)?.intValue)!
                                
                        }
                    }
                    
                    DispatchQueue.main.async
                    {
                        self.table.reloadData()
                    }
                }
            
            })
         })
            
      }
   }
        
       // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //this line is going to use the cells instead of creating them so
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellOne", for: indexPath)
        
        if let myCell = cell as? ChatViewCell
        {
             let mesg = messageArray[indexPath.row]
             myCell.userdata(msg: mesg)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        //selectedLabel = self.chatuserArray[indexPath.row]
        performSegue(withIdentifier:"Messages2", sender:self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier != nil
        {
            if let destinationvc = segue.destination as? ChatViewController
            {
              //destinationvc.chatUserName = selectedLabel
            }
        }
        
    }
    
    @IBAction func LogOut(_ sender: UIBarButtonItem)
    {
        do
        {
            try FIRAuth.auth()?.signOut()
            let mainStoryboard = UIStoryboard(name: "My", bundle: Bundle.main)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "Login") as UIViewController
            self.present(vc, animated: true, completion: nil)

        }
        
        catch
        {
          print("error")
        }
        
    }
}
