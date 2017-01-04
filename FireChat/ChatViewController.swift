//
//  ChatViewController.swift
//  
//
//  Created by mohsin raza on 19/12/2016.
//
//

import UIKit

class ChatViewController:UIViewController,UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var messageBox: UITextField!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    var userid:String?
    var bartitle:String?
    var chatUserName:Users?
    
    private var presenterDelegate:ChatPresenter?
    private var presenterDataSource:ChatPresenter?
    private var presenter:ChatPresenter?

   
//    {
//        didSet
//        {
//            if let object1 = chatUserName as? Users
//            {
//                bartitle = object1.name
//                userid = object1.id
//            }
//        }
//    }
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        presenterDelegate = ChatPresenter()
        presenterDataSource = ChatPresenter()
        presenter = ChatPresenter()
        //presenterDataSource?.datasource = self
        presenterDelegate?.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        self.navTitle.title = bartitle
    
    // Register cell classes
     self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "msg")
        
    }
    
    @IBAction func sendMessage(_ sender: UIButton)
    {
        presenter?.setChat(chatUserName,messageBox.text)
    }
    
    
    @IBAction func backToChat(_ sender: UIBarButtonItem)
    {
        let mainStoryboard = UIStoryboard(name: "My", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "Home") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}


extension ChatViewController:UICollectionViewDelegate
{



}

extension ChatViewController:UICollectionViewDataSource
{
    
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
}


extension ChatViewController:ViewDelegate
{
    
    
    
}

//extension ChatViewController:ViewDataSource
//{
//    
//    
//    
//}






