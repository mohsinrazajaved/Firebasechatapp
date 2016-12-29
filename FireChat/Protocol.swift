//
//  Protocol.swift
//  FireChat
//
//  Created by mohsin raza on 27/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation

@objc protocol ViewDelegate:class
{
    @objc optional func myerror(_ title:String,_ message:String)
    @objc optional func indicator()
    @objc optional func loginIndicator()
    @objc optional func setContacts(_ userarray:[Users])
    
}
