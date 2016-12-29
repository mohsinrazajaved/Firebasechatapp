//
//  ChatViewController.swift
//  
//
//  Created by mohsin raza on 19/12/2016.
//
//

import UIKit
import Firebase

class ChatViewController:UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var messageBox: UITextField!
    @IBOutlet weak var navTitle: UINavigationItem!
    var userid:String?
    var bartitle:String?
    
    var chatUserName:AnyObject?
    {
        didSet
        {
            if let object1 = chatUserName as? Users
            {
                bartitle = object1.name
                userid = object1.id
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.navTitle.title = bartitle
    
    // Register cell classes
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "msg")
        
    }
    
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"msg", for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    @IBAction func sendMessage(_ sender: UIButton)
    {
        //guard statements works like if let ,but does not bound you
        guard let messg = self.messageBox?.text , let toid = userid ,let fromid = FIRAuth.auth()?.currentUser?.uid  else
        {
            return
        }
        
        let usersReference = FireService.fireservice.BASE_REF.child("messages")
        let childRef = usersReference.childByAutoId()
        let timeStamp = Int(NSDate().timeIntervalSince1970)
    
        let values = ["text":messg,"toid":toid,"fromid":fromid,"timestamp":String(timeStamp)]
        
        
        childRef.updateChildValues(values)
        {(error, databaseReference) in
        
            if error != nil
            {
              
                print(error.debugDescription)
                return
            
            }
            
            let msgReference = FireService.fireservice.BASE_REF.child("user messages").child(fromid)
            let autoRef = childRef.key
            msgReference.updateChildValues([autoRef:1])

            let recipentUserMessageReference = FireService.fireservice.BASE_REF.child("user messages").child(toid)
            recipentUserMessageReference.updateChildValues([autoRef:1])

        }
        
    }
    
    
    @IBAction func backToChat(_ sender: UIBarButtonItem)
    {
        let mainStoryboard = UIStoryboard(name: "My", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "Home") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}





