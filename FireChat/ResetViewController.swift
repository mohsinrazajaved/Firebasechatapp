//
//  PasswordResetViewController.swift
//  moV
//
//  Created by mohsin raza on 9/23/16.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import UIKit
import QuartzCore

class ResetViewController: UIViewController
{
    
    @IBOutlet weak var Email: UITextField!
    let alert = UIAlertController()
    private var presenter:ResetPresenter?
    
    override func viewDidLoad()
    {
         Email.delegate = self
         presenter = ResetPresenter()
         presenter?.delegate = self
        
         self.navigationController?.isNavigationBarHidden = false
    }
    
   @IBAction func Resetpassword(_ sender: UIButton)
    {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Checking"
        presenter?.setReset(Email.text)
    }
    
}

//code seperation
extension ResetViewController:ViewDelegate
{
    func myerror(_ title:String,_ message:String)
    {
        alert.create(title:title, message: message)
    }
    
    func indicator()
    {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

//code seperation
extension ResetViewController:UITextFieldDelegate
{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        Email.resignFirstResponder()
        return true;
    }

}










