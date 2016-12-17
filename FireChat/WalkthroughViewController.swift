//
//import UIKit
//
//class WalkthroughViewController: UIViewController
//{
//
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var pageControl: UIPageControl!
//    @IBOutlet weak var nextButton: UIButton!
//    @IBOutlet weak var startButton: UIButton!
//    
//    
//    //public api
//    var index = 0
//    var imageName = ""
//    
//    
//    override var preferredStatusBarStyle : UIStatusBarStyle
//    {
//        return .lightContent
//    }
//    
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        
//        imageView.image = UIImage(named: imageName)
//        pageControl.currentPage = index
//        startButton.isHidden = true
//        startButton.isHidden = (index == 2) ? false : true
//        nextButton.isHidden = (index == 2) ? true : false
//        startButton.layer.cornerRadius = 5.0
//        startButton.layer.masksToBounds = true
//    }
//    
//       
//    @IBAction func startClicked(_ sender:UIButton)
//    {
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(true, forKey: "DisplayedWalkthrough")
//        
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    
//    @IBAction func nextClicked(_ sender:UIButton)
//    {
//       if let pageViewController = self.parent as? PageViewController
//        {
//            pageViewController.nextPageWithIndex(index)
//        }
//        
//    }
//    
//    
//}
//
//
//
