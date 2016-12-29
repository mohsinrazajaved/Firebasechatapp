//
//  UsersTableViewController.swift
//  FireChat
//
//  Created by mohsin raza on 17/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import UIKit


class UsersTableViewController: UIViewController
{
    var userArray = [Users]()
    var selectedLabel:Users?
    private var presenter:UsersTablePresenter?

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        presenter = UsersTablePresenter()
        presenter?.delegate = self
        table.delegate = self
        table.dataSource = self
        presenter?.getContacts()
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

extension UsersTableViewController:UITableViewDataSource
{

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return userArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        //this line is going to use the cells instead of creating them so
        let cell = tableView.dequeueReusableCell(withIdentifier:"CustomCellOne",for: indexPath)
        
        if let myCell = cell as? TableViewCell
        {
            
            let users = userArray[indexPath.row]
            myCell.username?.text = users.name
            myCell.useremail?.text = users.email
            
            if let imageurl = users.profileImageUrl
            {
                myCell.userimage.layer.cornerRadius = myCell.userimage.frame.size.width / 2;
                myCell.userimage.clipsToBounds = true;
                myCell.userimage.downloadImageswithUrl(urlString:imageurl)
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        selectedLabel = self.userArray[indexPath.row]
        performSegue(withIdentifier:"Messages1", sender:self)
    }
}


extension UsersTableViewController:UITableViewDelegate
{
    
    
}


extension UsersTableViewController:ViewDelegate
{
    
    func setContacts(userarray:[Users])
    {
       userArray = userarray
       self.table.reloadData()
    }
    
}
    












