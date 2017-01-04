//
//  UsersTablePresenter.swift
//  FireChat
//
//  Created by mohsin raza on 29/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import Foundation

class UsersTablePresenter
{
    var delegate:ViewDataSource?
    private let fire_contact = FireContacts()
    
    func setContacts()
    {
        fire_contact.Contacts()
        {(data:[Users]) in
        
            self.delegate?.getContacts(data)
        }
    }
}
