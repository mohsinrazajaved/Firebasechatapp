//
//  LoginPresenter.swift
//  FireChat
//
//  Created by mohsin raza on 26/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation

class LoginPresenter
{
    
    weak var delegate:ViewDelegate?
    private let FireAuth_Api = FireAuthenticaton()
    
    func setLogin(_ userEmail:String?,_ userPassword:String?)
    {
        guard let email = userEmail ,let password = userPassword else
        {
            delegate?.indicator?()
            delegate?.myerror?("Oops!","Please enter some data and .Try again.")
            return
        }
        
        FireAuth_Api.loginRequest(email,password)
        {[weak weakself = self](msg: Bool) in
            
            if msg == true
            {
                weakself?.delegate?.loginIndicator?()
                return
            }
                
            else if msg == false
            {
                weakself?.delegate?.indicator?()
                weakself?.delegate?.myerror?("Oops!","Having some trouble sigin your account. Try again.")
            }
        }
        
    }
}
