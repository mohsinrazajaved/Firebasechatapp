//import UIKit
//
//class PageViewController: UIPageViewController
//{
//
//    
//    var pageImages = ["Card", "Card1", "Card2"]
//    
//    private struct storyboard
//    {
//      static let storyboredIdentifier = "WalkthroughViewController"
//    }
//    
//    override var preferredStatusBarStyle : UIStatusBarStyle
//    {
//        return .lightContent
//    }
//    
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        self.dataSource = self
//               
//        if let startWalkthroughVC = self.viewControllerAtIndex(0)
//        {
//            setViewControllers([startWalkthroughVC], direction: .forward, animated: true, completion: nil)
//        }
//        
//    }
//
//    func nextPageWithIndex(_ index: Int)
//    {
//        if let nextWalkthroughVC = self.viewControllerAtIndex(index+1)
//        {
//            setViewControllers([nextWalkthroughVC], direction: .forward, animated: true, completion: nil)
//        }
//    }
//    
//    func viewControllerAtIndex(_ index: Int) -> WalkthroughViewController?
//    {
//        if index == NSNotFound || index < 0 || index >= self.pageImages.count
//        {
//            return nil
//        }
//        
//         if let walkthroughViewController = storyboard?.instantiateViewController(withIdentifier:storyboard.storyboredIdentifier) as? WalkthroughViewController
//         {
//            walkthroughViewController.imageName = pageImages[index]
//            
//            walkthroughViewController.index = index
//            
//            return walkthroughViewController
//         }
//        
//        return nil
//    }
//}
//
//extension PageViewController : UIPageViewControllerDataSource
//{
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
//    {
//        var index = (viewController as! WalkthroughViewController).index
//        index += 1
//        return self.viewControllerAtIndex(index)
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        var index = (viewController as! WalkthroughViewController).index
//        index -= 1
//        return self.viewControllerAtIndex(index)
//    }
//}
//
