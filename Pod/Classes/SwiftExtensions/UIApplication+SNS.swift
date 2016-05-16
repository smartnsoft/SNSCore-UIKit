//
//  UIApplication+SNS.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 16/05/2016.
//
//

//MARK: UIApplication
public extension UIApplication{
  
  /**
   Retrieve the top active presented view controller actually displayed for the user
   
   - parameter base: The root view controller on any root into you want to retrieve the top view controller
   
   - returns: The Top UIVIewController
   */
  public class func topViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {
    
    if let nav = base as? UINavigationController {
      return topViewController(nav.visibleViewController)
    }
    
    if let tab = base as? UITabBarController {
      let moreNavigationController = tab.moreNavigationController
      
      if let top = moreNavigationController.topViewController where top.view.window != nil {
        return topViewController(top)
      } else if let selected = tab.selectedViewController {
        return topViewController(selected)
      }
    }
    
    if let presented = base?.presentedViewController {
      return topViewController(presented)
    }
    
    return base
  }
}