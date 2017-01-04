//
//  RecentMessagesViewController.swift
//  FireChat
//
//  Created by mohsin raza on 19/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import UIKit
class RecentMessagesViewController: UIViewController
{

    @IBOutlet weak var loginUserImage: UIImageView!
    @IBOutlet weak var loginUserTitle: UILabel!
    @IBOutlet weak var table: UITableView!


    static var selfobj:RecentMessagesViewController?
    var selectedLabel:Users?
    var messageArray = [Message]()
    var chatUser = [Users]()
    var userArray = [Users]()
    private var presenter:RecentPresenter?
    
    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        presenter = RecentPresenter()
        
        presenter?.datasource = self
        presenter?.delegate = self
        
        table.delegate = self
        table.dataSource = self
    
        presenter?.setRecents()
        presenter?.setMessages()
        
    }
    
    
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
    
    @IBAction func LogOut(_ sender: UIBarButtonItem)
    {
        presenter?.setSignOut()
    }
}

extension RecentMessagesViewController:UITableViewDataSource
{
    
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
            let chat = chatUser[indexPath.row]
            myCell.msg = mesg
            myCell.chatusername.text = chat.name
            myCell.chatuserimg.downloadImageswithUrl(urlString:chat.profileImageUrl!)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
//        let selectedMsg = self.chatuserArray[indexPath.row]
//        
//        //        guard let chatid = selectedMsg.chatPartenerId else
//        //        {
//        //            return
//        //        }
//        
        
        performSegue(withIdentifier:"Messages2", sender:self)
    }
}

extension RecentMessagesViewController:UITableViewDelegate
{
    //things will come here etc
}

extension RecentMessagesViewController:ViewDataSource
{
    func getContacts(_ userarray:[Users])
    {
         userArray = userarray
         self.loginUserTitle?.text = userArray[0].name
         self.loginUserImage.downloadImageswithUrl(urlString:userArray[0].profileImageUrl!)
    }
    
    func getMessages(_ messagearray:[Message],_ chatuserarray:[Users])
    {
        messageArray = messagearray
        chatUser = chatuserarray
        self.table.reloadData()
    }
}

extension RecentMessagesViewController:ViewDelegate
{
    func signOut()
    {
        let mainStoryboard = UIStoryboard(name: "My", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "Login") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
}


