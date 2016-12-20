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
    var messageArray = [Message]()
    var selectedLabel:Message?
    
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        self.observeMsg()
    }
    
    
    private func observeMsg()
    {
        //if FIRAuth.auth()?.currentUser?.uid == nil
        //        {
        let usersReference = FireService.fireservice.BASE_REF.child("messages")
        usersReference.observe(.childAdded, with:
            {(Snapshot) in
                
                if let dictionary =  Snapshot.value as? [String:String]
                {
                    
                    let obj = Message()
                    obj.setValuesForKeys(dictionary)
                    self.messageArray.append(obj)
                    print(Snapshot)
                    
                    DispatchQueue.main.async
                        {
                            self.table.reloadData()
                    }
                    
                }
        })
        // }
        
        
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messageArray
            .count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //this line is going to use the cells instead of creating them so
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellOne", for: indexPath)
        
        if let myCell = cell as? ChatViewCell
        {
            
            let users = messageArray[indexPath.row]
            myCell.chatusername?.text = users.text
           
//            if let imageurl = users.profileImageUrl
//            {
//                myCell.userimage.layer.cornerRadius = myCell.userimage.frame.size.width / 2;
//                myCell.userimage.clipsToBounds = true;
//                myCell.userimage.downloadImageswithUrl(urlString:imageurl)
//            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        selectedLabel = self.messageArray[indexPath.row]
        performSegue(withIdentifier:"Messages2", sender:self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier != nil
        {
            if let destinationvc = segue.destination as? ChatViewController
            {
                destinationvc.chatUserName = selectedLabel
            }
            
        }
        
    }
    

}
