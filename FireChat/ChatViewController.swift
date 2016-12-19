//
//  ChatViewController.swift
//  
//
//  Created by mohsin raza on 19/12/2016.
//
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class ChatViewController:UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var messageBox: UITextField!
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

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
        
        guard let messg = self.messageBox?.text else
        {
            return
        }
        
        let usersReference = FireService.fireservice.BASE_REF.child("messages")
        let childRef = usersReference.childByAutoId()
        let values = ["text":messg]
        childRef.updateChildValues(values)
    }
    
}
