//
//  RecentPresenter.swift
//  FireChat
//
//  Created by mohsin raza on 30/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation

class ResentPresenter
{
    var delegate:ViewDataSource?
    var datasource:ViewDelegate?
    private let fire_contact = FireContacts()
    private let fire_auth = FireAuthenticaton()
    
    func getRecents()
    {
        
        fire_contact.observeUser()
        {[weak weakself = self](data:[Users]) in
                
            weakself?.delegate?.setContacts(data)
        }
        
    }
    
    func getMessages()
    {
        fire_contact.observeMsg()
        {[weak weakself = self](data:[Message]) in
            
            weakself?.delegate?.setContacts(data)
        }
    }
    
    func getSignOut()
    {
        fire_auth.logoutRequest()
        {[weak weakself = self](data:Bool) in
            
            if data != true
            {
                weakself?.datasource?.signOut()
            }
            
            else
            {
            
              
            
            }
        }
    }
}
