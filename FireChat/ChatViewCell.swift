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
              profileUserImage()
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
    

   private func profileUserImage()
   {
        guard let id  = msg?.chatPartenerId else
        {
           return
        }
    
        let usersRef = FireService.fireservice.BASE_REF.child("users").child(id)
        usersRef.observeSingleEvent(of:.value, with:
        {(Snapshot) in
                
                if let dictionary = Snapshot.value as? [String:String]
                {
                    let users = Users()
                    users.setValuesForKeys(dictionary)
                    
                    DispatchQueue.main.async
                    {
                            self.chatusername?.text = users.name
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


