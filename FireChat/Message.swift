//
//  Message.swift
//  FireChat
//
//  Created by mohsin raza on 19/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation
import Firebase

struct Message
{

    var fromid:String?
    var text:String?
    var timestamp:String?
    var toid:String?
    
    init(_ fromid:String?,_ text:String?,_ timestamp:String?,_ toid:String?)
    {
        
        self.fromid = fromid
        self.text = text
        self.timestamp = timestamp
        self.toid = toid
    }
    
    //computed property
    var chatPartenerId:String?
    {
      return fromid == FIRAuth.auth()?.currentUser?.uid ? toid:fromid
    }
    
}
