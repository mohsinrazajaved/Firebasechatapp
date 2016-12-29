//
//  ViewController.swift
//  moV
//
//  Created by mohsin raza on 9/21/16.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import UIKit
import QuartzCore


class LoginViewController:UIViewController
{

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    let alert = UIAlertController()
    private var presenter:LoginPresenter?
    
       
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Email.delegate = self
        Password.delegate = self
        presenter = LoginPresenter()
        presenter?.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        //presenter?.check()
       
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = true
       //self.displayWalkthroughs()
    }

    
    @IBAction func Logintofirebase(_ sender: UIButton)
    {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"

        presenter?.setLogin(Email.text,Password.text)
    }

}

//code seperation
extension LoginViewController:ViewDelegate
{
    func myerror(_ title:String,_ message:String)
    {
        alert.create(title:title, message: message)
    }
    
    func indicator()
    {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func loginIndicator()
    {
        //this method is called by the presenter to update the view
        MBProgressHUD.hide(for: self.view, animated: true)
        let mainStoryboard = UIStoryboard(name: "My", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "Home") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
}


//code seperation
extension LoginViewController:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        Email.resignFirstResponder()
        Password.resignFirstResponder()
        return true;
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

