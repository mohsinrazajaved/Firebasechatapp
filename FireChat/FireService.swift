//
//  FireService.swift
//  FireChat
//
//  Created by mohsin raza on 30/11/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation
import Firebase

class FireService
{

    static let fireservice = FireService()
    
    //computed properties
  
    var STORAGE_IMAGES:FIRStorageReference
    {
        return FIRStorage.storage().reference().child("profile_images")
    }
    
    var BASE_REF:FIRDatabaseReference
    {
        return FIRDatabase.database().reference()
    }

    var CURRENT_USER_REF:FIRDatabaseReference
    {
        let userID = UserDefaults.standard.value(forKey: "uid") as! String
        let currentUser = BASE_REF.child("users").child(userID)
        return currentUser
    }
    
}
    
