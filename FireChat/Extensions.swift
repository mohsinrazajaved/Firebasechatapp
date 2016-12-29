//
//  Extensions.swift
//  FireChat
//
//  Created by mohsin raza on 02/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import UIKit

 let imageCache = NSCache<NSString,UIImage>()

extension UIAlertController
{
    
    func create(title : String,message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        alert.show()
    }
    
    func show()
    {
        present(animated: true, completion: nil)
    }
    
    func present(animated: Bool, completion: (() -> Void)?)
    {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            presentFromController(controller: rootVC, animated: animated, completion: completion)
        }
    }
    
    private func presentFromController(controller: UIViewController, animated: Bool, completion: (() -> Void)?)
    {
        if let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController
        {
            presentFromController(controller: visibleVC, animated: animated, completion: completion)
        }
        else
            
        if let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController
        {
            presentFromController(controller: selectedVC, animated: animated, completion: completion)
        }
        else
        {
            controller.present(self, animated: animated, completion: completion);
        }
    }
}




extension PageViewController : UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! WalkthroughViewController).index
        index += 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughViewController).index
        index -= 1
        return self.viewControllerAtIndex(index)
    }
}


extension UIImageView
{
    
    func downloadImageswithUrl(urlString:String)
    {
        self.image = nil
        
        if let cachedImages = imageCache.object(forKey:urlString as NSString)
        {
            self.layer.cornerRadius = self.frame.size.width / 2;
            self.clipsToBounds = true;
            self.image = cachedImages
            return
        }
        
        
        if let url = URL(string:urlString)
        {
            //downloading the images
            URLSession.shared.dataTask(with:url,completionHandler:
                {(data, response, error) in
                    
                    if error != nil
                    {
                        
                        print("error")
                        return
                    }
                    
                    //updating our ui on the main thread
                    DispatchQueue.main.async
                    {
                        if let image = data
                        {
                            if let downloadImage = UIImage(data:image)
                            {
                                
                                imageCache.setObject(downloadImage, forKey: urlString as NSString)
                                self.image = downloadImage
                                
                            }
                        }
                    }
                    
            }).resume()
      }


    }

}

