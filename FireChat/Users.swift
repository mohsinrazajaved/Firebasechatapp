//
//  Users.swift
//  FireChat
//
//  Created by mohsin raza on 17/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation
struct Users
{
    var id:String?
    var name:String?
    var email:String?
    var profileImageUrl:String?
    
    init(_ name:String?,_ email:String?,_ profileImageUrl:String?,_ id:String?)
    {
        self.name = name
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.id = id
    }
}



