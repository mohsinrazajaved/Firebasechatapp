//
//  ChatPresenterr.swift
//  FireChat
//
//  Created by mohsin raza on 30/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation

class ChatPresenter
{
    
    var delegate:ViewDelegate?
    var datasource:ViewDataSource?
    private let fire_contact = FireMessages()
    
    
    
    func setChat(_ person:Users?,_ msg:String?)
    {
        
//       if msg != ""  && person.userid != "" ,let fromid = FIRAuth.auth()?.currentUser?.uid  else
//       {
//
//        fire_contact.Messages(msg)
//        {[weak weakself = self](data:Bool) in
//            
//            if data != true
//            {
//              // weakself?.datasource?.setContacts(data)
//            }
//            
//            else
//            {
//               
//            }
//          }
//       }
    }
}
