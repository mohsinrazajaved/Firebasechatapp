//
//  SignupPresenter.swift
//  FireChat
//
//  Created by mohsin raza on 26/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation

class SignupPresenter:NSObject
{

    weak var delegate:ViewDelegate?
    private let FireAuth_Api = FireAuthenticaton()
    
    
    func setSignup(_ userImage:Data,_ userEmail:String?,_ userPassword:String?,_ userName:String?)
    {
               
        if userEmail != "" && userPassword != "" && userName != ""
        {
        
        FireAuth_Api.signupRequest(userImage,userEmail!,userPassword!,userName!)
        {[weak weakself = self](msg: Bool) in
            
            if msg == true
            {
                weakself?.delegate?.indicator?()
                return
            }
                
            else if msg == false
            {
                weakself?.delegate?.indicator?()
                weakself?.delegate?.myerror?("Oops!","Try again or Use different email.")
            }
        }
     }
     else
     {
    
        delegate?.indicator?()
        delegate?.myerror?("Oops!","Please enter some data and .Try again.")
        return

     }
   }
}
