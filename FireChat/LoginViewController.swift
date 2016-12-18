//
//  ViewController.swift
//  moV
//
//  Created by mohsin raza on 9/21/16.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase

class LoginViewController:UIViewController,UITextFieldDelegate
{

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    let alert = UIAlertController()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Email.delegate = self
        Password.delegate = self
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
       //self.displayWalkthroughs()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        Email.resignFirstResponder()
        Password.resignFirstResponder()
        return true;
    }

    
    @IBAction func Logintofirebase(_ sender: UIButton)
    {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"

      guard let email = Email.text,let password = Password.text else
      {
          alert.create(title: "Oops!",message: "Try again.")
          return
      }
        
        FIRAuth.auth()?.signIn(withEmail: email, password:password)
        {[weak weakself = self](user:FIRUser?,error) in
                
                if error != nil
                {
                    
                 weakself?.alert.create(title: "Oops!", message: "Having some trouble sigin your account. Try again.")
                 return
                
                }
            
            MBProgressHUD.hide(for: self.view, animated: true)
            let mainStoryboard = UIStoryboard(name: "My", bundle: Bundle.main)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "Home") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
//  private func displayWalkthroughs()
//    {
//        
//          let userDefaults = UserDefaults.standard
////        let displayedWalkthrough = userDefaults.bool(forKey: "DisplayedWalkthrough")
////        
////        if !displayedWalkthrough
////        {
////            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? PageViewController
////            {
////                self.present(pageViewController, animated: true, completion: nil)
////            }
////        }
//    }


}

