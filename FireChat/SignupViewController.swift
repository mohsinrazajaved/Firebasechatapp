//
//  SignupViewController.swift
//  moV
//
//  Created by mohsin raza on 9/23/16.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import UIKit
import QuartzCore


class SignupViewController: UIViewController,UINavigationControllerDelegate
{
    
    @IBOutlet weak var Profilepic: UIImageView!
    @IBOutlet weak var Imagepicker:UIBarButtonItem!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
   
    let imagePicker = UIImagePickerController()
    let alert  = UIAlertController()
    let obj = Users()
    private var presenter:SignupPresenter?
    
    
    override func viewDidLoad()
    {
        
          Username.delegate = self
          Password.delegate = self
          imagePicker.delegate = self
          Email.delegate = self
          presenter = SignupPresenter()
          presenter?.delegate = self
          Profilepic.layer.cornerRadius = self.Profilepic.frame.size.width / 2;
          Profilepic.clipsToBounds = true;
          self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func loadImageButtonTapped(_ sender: UIBarButtonItem)
    {
        self.imagepicker()
    }
    

     // MARK: - Firebase Methods
    
    @IBAction func Signup(_ sender: UIButton)
    {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        isImageNil()
        
    }
    
    func imagepicker()
    {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func isImageNil()
    {
        if let pngImg = self.Profilepic.image
        {
            if let uploadData = UIImageJPEGRepresentation(pngImg,0.1)
            {
              presenter?.setSignup(uploadData,Email.text, Password.text, Username.text)
            }
        }
            
        else
        {
            MBProgressHUD.hide(for: self.view, animated: true)
            print("error")
        }
    }
}


//code seperation
extension SignupViewController:ViewDelegate
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
extension SignupViewController:UITextFieldDelegate
{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        Username.resignFirstResponder()
        Email.resignFirstResponder()
        Password.resignFirstResponder()
        return true;
    }
}


//code seperation
extension SignupViewController:UIImagePickerControllerDelegate
{
    // MARK: - UIImagePickerControllerDelegate Methods + custom
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            self.Profilepic.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
}



