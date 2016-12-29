//
//  ApiManager.swift
//  FireChat
//
//  Created by mohsin raza on 26/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation
import Firebase

class FireAuthenticaton
{
    
    private let user = Users()
  
    //user passsword reset
    func resetRequest(_ user_email:String,_ completion: @escaping ((_ msg: Bool) -> ()))
    {
        
        FIRAuth.auth()?.sendPasswordReset(withEmail:user_email)
        {(error) in
            
            if(error != nil)
            {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    //user login
    func loginRequest(_ useremail:String,_ userpassword:String,_ completion: @escaping ((_ msg: Bool) -> ()))
    {
        FIRAuth.auth()?.signIn(withEmail:useremail, password:userpassword)
        {(user:FIRUser?,error) in
            
            if error != nil
            {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    //user signup
    func signupRequest(_ convertImage:Data,_ useremail:String,_ userpassword:String,_ username:String,_ completion: @escaping ((_ msg: Bool) -> ()))
    {
        FIRAuth.auth()?.createUser(withEmail: useremail, password: userpassword)
        {(user,error) in
            
            if(error != nil)
            {
                completion(false)
                return
            }
            
            let imageName = UUID().uuidString
            let storageRef = FireService.fireservice.STORAGE_IMAGES.child("\(imageName).jpg")
            
            storageRef.put(convertImage, metadata: nil)
            {(metadata, error) in
                
                if error != nil
                {
                    completion(false)
                    return
                }
            
            
            if let profileImageUrl = metadata?.downloadURL()?.absoluteString
            {
                let values = ["name": username, "email": useremail, "profileImageUrl": profileImageUrl] as [String:String]
               
                guard let uid = FIRAuth.auth()?.currentUser?.uid else
                {
                    completion(false)
                    return
                }
              
            let usersReference = FireService.fireservice.BASE_REF.child("users").child(uid)
            usersReference.updateChildValues(values)
            {(error, ref) in
                
                if error != nil
                {
                    completion(false)
                    return
                }
            }
              completion(true)
          }
        }
     }
  }}

