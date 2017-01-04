//
//  FireMessages.swift
//  FireChat
//
//  Created by mohsin raza on 30/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation
import Firebase

class FireMessages
{
    func getCurrentID() ->String?
    {
//        if FIRAuth.auth()?.currentUser?.uid != ""
//        {
//           return
//        }
        
        return ""
    }

    func Messages(_ obj:Message ,_ completion: @escaping ((_ data:Bool) -> ()))
    {
       let usersReference = FireService.fireservice.BASE_REF.child("messages")
       let childRef = usersReference.childByAutoId()
       let timeStamp = Int(NSDate().timeIntervalSince1970)

       let values = ["text":obj.text,"toid":obj.toid,"fromid":obj.fromid,"timestamp":String(timeStamp)]

      childRef.updateChildValues(values)
      {(error, databaseReference) in
    
        if error != nil
        {
          completion(false)
          return
        }
    
        let msgReference = FireService.fireservice.BASE_REF.child("user messages").child(obj.fromid!)
        let autoRef = childRef.key
        msgReference.updateChildValues([autoRef:1])
    
        let recipentUserMessageReference = FireService.fireservice.BASE_REF.child("user messages").child(obj.toid!)
        recipentUserMessageReference.updateChildValues([autoRef:1])
        
        completion(true)
      }
   }
}
