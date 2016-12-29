//
//  Protocol.swift
//  FireChat
//
//  Created by mohsin raza on 27/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation


//resuable protocol for many classes
//callbacks can be used for this purpose
//we use callbacks and delegation so that our presenter or viewmodal can give data to our view or update it

@objc protocol ViewDelegate:class
{
    //can contain optional methods
    @objc optional func myerror(_ title:String,_ message:String)
    @objc optional func indicator()
    @objc optional func loginIndicator()
}
