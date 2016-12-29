//
//  Message.swift
//  FireChat
//
//  Created by mohsin raza on 19/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation
import Firebase

class Message:NSObject
{

    var fromid:String?
    var text:String?
    var timestamp:String?
    var toid:String?
    
    //computed property
    var chatPartenerId:String?
    {
      return fromid == FIRAuth.auth()?.currentUser?.uid ? toid:fromid
    }
    
}
