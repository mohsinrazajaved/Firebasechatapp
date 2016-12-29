//
//  RessetPresenter.swift
//  FireChat
//
//  Created by mohsin raza on 26/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation

class ResetPresenter
{
 
  weak var delegate:ViewDelegate?
  private let FireAuth_Api = FireAuthenticaton()
    
    func setReset(_ userEmail:String?)
    {
        if userEmail != ""
        {
            FireAuth_Api.resetRequest(userEmail!)
            {[weak weakself = self](msg: Bool) in
                
                if msg == true
                {
                    weakself?.delegate?.indicator?()
                    weakself?.delegate?.myerror?("Done","Verification email is send to you!!!.")
                    return
                }
                    
                else if msg == false
                {
                    weakself?.delegate?.indicator?()
                    weakself?.delegate?.myerror?("Oops!","Having some trouble. Try again.")
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
