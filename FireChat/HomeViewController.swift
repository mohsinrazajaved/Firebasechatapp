//
//  MenuViewController.swift
//  moV
//
//  Created by mohsin raza on 9/24/16.
//  Copyright © 2016 mohsin raza. All rights reserved.
//


import UIKit
import QuartzCore
import Firebase

class HomeViewController: UIViewController
{
    
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var profileimage: UIImageView!
    
    override func viewDidLoad()
    {
        profileimage.layer.cornerRadius = self.profileimage.frame.size.width / 2;
        profileimage.clipsToBounds = true;
        isUserLogin()
    }
    
    
    private func isUserLogin()
    {
        
        if FIRAuth.auth()?.currentUser?.uid != nil
        {
            
            let uid = FIRAuth.auth()?.currentUser?.uid
            let usersReference = FireService.fireservice.BASE_REF.child("users").child(uid!)
            usersReference.observeSingleEvent(of:.value, with:
                {(Snapshot) in
                    
                    if let dictionary =  Snapshot.value as? [String:String]
                    {
                        if let dict = dictionary["name"], let picurl = dictionary["profileImageUrl"], let url = URL(string:picurl)
                        {
                            
                            URLSession.shared.dataTask(with: url,completionHandler:
                                {(data, response, error) in
                                    
                                    if error != nil
                                    {
                                        
                                        print(error?.localizedDescription as Any)
                                        return
                                    }
                                    
                                    DispatchQueue.main.async
                                        {
                                            self.userName?.text = dict
                                            
                                            if let image = data
                                            {
                                                self.profileimage?.image = UIImage(data:image)
                                            }
                                    }
                            }).resume()
                            
                        }
                        
                    }
                    
            }, withCancel: nil)
        }
    }
    
    @IBAction func finished(_: AnyObject?)
    {
        do
        {
          try FIRAuth.auth()?.signOut()
        }
        catch
        {
            print(error)
        }

      self.dismiss(animated: true, completion: nil)
        
    }
}
