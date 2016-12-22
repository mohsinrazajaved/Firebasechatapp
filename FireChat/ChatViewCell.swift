//
//  ChatViewCell.swift
//  
//
//  Created by mohsin raza on 20/12/2016.
//
//

import UIKit
import Firebase

class ChatViewCell: UITableViewCell
{
    
    @IBOutlet weak var chatuserimg: UIImageView!
    @IBOutlet weak var chatusername: UILabel!
    @IBOutlet weak var chatusertimestamp: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    func userdata(msg:Message)
    {
    
        if let uniqueid = msg.toid
        {
            
            let usersRef = FireService.fireservice.BASE_REF.child("users").child("\(uniqueid)")
            usersRef.observeSingleEvent(of:.value, with:
            {(Snapshot) in
                    
                    if let dictionary = Snapshot.value as? [String:String]
                    {
                        let users = Users()
                        users.setValuesForKeys(dictionary)
                    
                        DispatchQueue.main.async
                        {
                                self.chatusername?.text = users.name
                                self.chatusertimestamp?.text = msg.text
                            
                            if let seconds =  Double(msg.timestamp!)
                            {
                                let timestampDate = Date(timeIntervalSince1970:seconds)
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "hh:mm:ss a"
                                self.timeStamp?.text = dateFormatter.string(from: timestampDate)
                                
                            }
                                if let imageurl = users.profileImageUrl
                                {
                                    self.chatuserimg.layer.cornerRadius = self.chatuserimg.frame.size.width / 2;
                                    self.chatuserimg.clipsToBounds = true;
                                    self.chatuserimg.downloadImageswithUrl(urlString:imageurl)
                                }
                        }
                        
                }
           })
      }
        
 }
    
}
