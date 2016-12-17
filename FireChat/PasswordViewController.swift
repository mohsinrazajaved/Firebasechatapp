//
//  PasswordResetViewController.swift
//  moV
//
//  Created by mohsin raza on 9/23/16.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase

class PasswordViewController: UIViewController,UITextFieldDelegate
{
    
    @IBOutlet weak var Email: UITextField!
    let alert = UIAlertController()
    
    
    override func viewDidLoad()
    {
        
         Email.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        Email.resignFirstResponder()
        return true;
    }


   @IBAction func Resetpassword(_ sender: UIButton)
    {
      
        guard let email = Email.text else
        {
            alert.create(title: "Oops!", message: "Having some trouble resetting your password. Try again.")
            return
        }

        FIRAuth.auth()?.sendPasswordReset(withEmail: email)
        {[weak weakself = self](error) in
            
            if(error != nil)
            {
              weakself?.alert.create(title: "Oops!", message: "Having some trouble. Try again.")
            }
            else
            {
              weakself?.alert.create(title: "Done", message: "Verification email is send to you!!!.")
            }
        }
    }
    
}



