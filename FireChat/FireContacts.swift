//
//  FireDatabase.swift
//  FireChat
//
//  Created by mohsin raza on 29/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation
import Firebase

class FireContacts
{
    var userArray = [Users]()
    var messageArray = [Message]()
    var messageDictionary = [String:Message]()
    var chatUser = [Users]()

    func Contacts(_ completion: @escaping ((_ data: [Users]) -> ()))
    {

        if FIRAuth.auth()?.currentUser?.uid != nil
        {
            let usersReference = FireService.fireservice.BASE_REF.child("users")
            
            usersReference.observe(.childAdded, with:
            {[weak weakself = self](Snapshot) in
                
                    if let dictionary =  Snapshot.value as? [String:String]
                    {
                        let obj = Users(dictionary["name"],dictionary["email"],dictionary["profileImageUrl"],Snapshot.key)
                        weakself?.userArray.append(obj)
                        
                    }
                
                DispatchQueue.main.async
                {
                    completion((weakself?.userArray)!)
                    
                }
            })
        }
    }
    
    func partners(_ array:[Message])->[Users]
    {
        for msg in array
        {
            
        let chatReference = FireService.fireservice.BASE_REF.child("users").child(msg.chatPartenerId!)
        chatReference.observeSingleEvent(of:.value, with:
        {[weak weakself = self](Snapshot) in
            
                 print("\(Snapshot)**********")
                
                if let dictionary =  Snapshot.value as? [String:String]
                {
                    let obj = Users(dictionary["name"],dictionary["email"],dictionary["profileImageUrl"],Snapshot.key)
                    weakself?.chatUser.append(obj)
                }
        })
      }
        
        return chatUser
    }

    func observeUser(_ completion: @escaping ((_ data: [Users]) -> ()))
    {
        if FIRAuth.auth()?.currentUser?.uid != nil
        {
            print((FIRAuth.auth()?.currentUser?.uid)!)
            let usersReference = FireService.fireservice.BASE_REF.child("users").child((FIRAuth.auth()?.currentUser?.uid)!)
            usersReference.observeSingleEvent(of:.value, with:
            {[weak weakself = self](Snapshot) in
                
                if let dictionary =  Snapshot.value as? [String:String]
                {
                    let obj = Users(dictionary["name"],dictionary["email"],dictionary["profileImageUrl"],Snapshot.key)
                    weakself?.userArray.append(obj)
                }
            })
        }
    }
    
    
    func observeMsg(_ completion: @escaping ((_ data: [Message]) -> ()))
    {
        if let uid = FIRAuth.auth()?.currentUser?.uid
        {
            
            let usersReference = FireService.fireservice.BASE_REF.child("user messages").child(uid)
            usersReference.observe(.childAdded, with:
            {(Snapshot) in
                    
                    let messageReference = FireService.fireservice.BASE_REF.child("messages").child(Snapshot.key)
                    
                    messageReference.observeSingleEvent(of:.value, with:
                    {[weak weakself = self](DataSnapshot) in
                            
                            if let dict =  DataSnapshot.value as? [String:String]
                            {
                                let message = Message(dict["fromid"],dict["text"],dict["timestamp"],dict["toid"])
                                
                                if let toId = message.toid
                                {
                                    weakself?.messageDictionary[toId] = message
                                    weakself?.messageArray = Array(self.messageDictionary.values)
                                    weakself?.messageArray = self.messageArray.sorted
                                    {
                                    
                                       (NumberFormatter().number(from: $0.timestamp!)?.intValue)!
                                                >
                                       (NumberFormatter().number(from: $1.timestamp!)?.intValue)!
                                            
                                    }
                                    
                             }
                               
                                DispatchQueue.main.async
                                {
                                  completion((weakself?.messageArray)!)
                                }
                            }
                    })
              })
        }
    }
}
