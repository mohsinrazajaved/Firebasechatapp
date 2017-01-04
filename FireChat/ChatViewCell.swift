//
//  ChatViewCell.swift
//  
//
//  Created by mohsin raza on 20/12/2016.
//
//

import UIKit
import Firebase

class ChatViewCell:UITableViewCell
{
    
    @IBOutlet weak var chatuserimg: UIImageView!
    @IBOutlet weak var chatusername: UILabel!
    @IBOutlet weak var chatusertimestamp: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
   
    var msg:Message?
    {
       didSet
       {
            chatusertimestamp?.text = msg?.text
            
            if let seconds =  Double((msg?.timestamp!)!)
            {
                let timestampDate = Date(timeIntervalSince1970:seconds)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                timeStamp?.text = dateFormatter.string(from: timestampDate)
            }
        
        }
    }
}


