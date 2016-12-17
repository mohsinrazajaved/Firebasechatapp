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
        //profileimage.layer.cornerRadius = self.profileimage.frame.size.width / 2;
        //rprofileimage.clipsToBounds = true;
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
            
                print(Snapshot)
            
            if let dictionary =  Snapshot.value as? [String:String]
            {
                DispatchQueue.main.async
                {
                    if let dict = dictionary["name"]
                    {
                        self.userName?.text = dict
                    }
                }
            }
            
        }, withCancel: nil)
     }
  }
    @IBAction func finished(_: AnyObject?)
    {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Signoutmenu(_ sender: UIButton)
    {
       
//        do
//        {
//           try FIRAuth.auth()?.signOut()
//        }
//        catch
//        {
//            print(error)
//        }
        
        self.presentedViewController?.dismiss(animated: true)
    }
}
