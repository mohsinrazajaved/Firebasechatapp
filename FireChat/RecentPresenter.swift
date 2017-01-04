//
//  RecentPresenter.swift
//  FireChat
//
//  Created by mohsin raza on 30/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation

class RecentPresenter
{
    var delegate:ViewDelegate?
    var datasource:ViewDataSource?
    private let fire_contact = FireContacts()
    private let fire_auth = FireAuthenticaton()
    
    func setRecents()
    {
        
        fire_contact.observeUser()
        {[weak weakself = self](data:[Users]) in
                
            weakself?.datasource?.getContacts(data)
        }
    }
    
    func setMessages()
    {
        fire_contact.observeMsg()
        {[weak weakself = self](data:[Message]) in
            weakself?.datasource?.getMessages(data,(weakself?.fire_contact.partners(data))!)
        }
    }
    
    func setSignOut()
    {
        fire_auth.logoutRequest()
        {[weak weakself = self](data:Bool) in
            
            if data != true
            {
                weakself?.delegate?.signOut?()
            }
            
            else
            {
               weakself?.delegate?.myerror?("Oopss","Unable to SignOut")
            }
        }
    }
}
