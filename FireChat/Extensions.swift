//
//  Extensions.swift
//  FireChat
//
//  Created by mohsin raza on 02/12/2016.
//  Copyright © 2016 mohsin raza. All rights reserved.
//

import UIKit

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

