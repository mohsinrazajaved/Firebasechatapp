//
//  SignupViewController.swift
//  moV
//
//  Created by mohsin raza on 9/23/16.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase

class SignupViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    @IBOutlet weak var Profilepic: UIImageView!
    @IBOutlet weak var Imagepicker:UIBarButtonItem!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
   
    let imagePicker = UIImagePickerController()
    let alert  = UIAlertController()
    
    
    override func viewDidLoad()
    {
          Username.delegate = self
          Password.delegate = self
          imagePicker.delegate = self
          Email.delegate = self
          Profilepic.layer.cornerRadius = self.Profilepic.frame.size.width / 2;
          Profilepic.clipsToBounds = true;
          Profilepic.image = UIImage(named: "user")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        Username.resignFirstResponder()
        Email.resignFirstResponder()
        Password.resignFirstResponder()
        return true;
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
        
        guard let email = Email.text ,let password = Password.text,let name = Username.text else
        {
            alert.create(title: "Oops!",message: "Try again.")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email,password: password)
            {(user,error) in
                
                if(error != nil)
                {
                    
                  self.alert.create(title: "Oops!", message: "Having some trouble creating your account. Try again.")
                  return
                }
                
                guard let uid = user?.uid else
                {
                    return
                }
                
                self.storeInfoInStorage(uid,email,name)
            }
    }
    
    
    private func storeInfoInStorage(_ uid_User:String,_ user_Email:String,_ user_Name:String)
    {
        //unique uid for each image
        let imageName = UUID().uuidString
        let storageRef = FireService.fireservice.STORAGE_IMAGES.child("\(imageName).png")

        guard let pngImg = self.Profilepic.image else
        {
           return
        }
        
        if let uploadData = UIImagePNGRepresentation(pngImg)
        {
            storageRef.put(uploadData, metadata: nil)
            {(metadata, error) in
               
                if error != nil
                {
                   self.alert.create(title: "Oops!", message: "Having some trouble storing your data. Try again.")
                   return
                }

                if let profileImageUrl = metadata?.downloadURL()?.absoluteString
                {
                    let values = ["name": user_Name, "email": user_Email, "profileImageUrl": profileImageUrl] as [String:String]
                    self.registerUserIntoDatabaseWithUID(uid_User,values)
                }
            }
        }
    }
        
    private func registerUserIntoDatabaseWithUID(_ uid: String,_ values: [String:String])
    {
        
        let usersReference = FireService.fireservice.BASE_REF.child("users").child(uid)
        
        usersReference.updateChildValues(values)
        {[weak weakself = self](error, ref) in
            
            if error != nil
            {
                
               weakself?.alert.create(title: "Oops!", message: "Having some trouble in database Try again.")
               return
            }
           
            MBProgressHUD.hide(for: self.view, animated: true)
            weakself?.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods + custom
    
    func imagepicker()
    {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
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
