//
//  UIManager.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 08/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resizeImage(newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

class UIManager: NSObject {

    private static var _manager: UIManager?
    
    public static func sharedInstance() -> UIManager {
        if _manager == nil {
            _manager = UIManager()
        }
        return _manager!
    }
    
    public func showAlert(_ msg: String, controller: UIViewController) {
        let alert : UIAlertController = UIAlertController.init(title: "提示", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let callaction = UIAlertAction(title: "確定",style: .default, handler: nil);
        
        alert.addAction(callaction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    public func showAlert(_ msg: String, controller: UIViewController, submit: (() -> Void)?) {
        let alert : UIAlertController = UIAlertController.init(title: "提示", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let okCallaction = UIAlertAction(title: "確定", style: .default) { (action) in
            submit?()
        }
        
        alert.addAction(okCallaction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    public func showAlert(_ msg: String, controller: UIViewController, submit: (() -> Void)?, cancel: (() -> Void)?) {
        let alert : UIAlertController = UIAlertController.init(title: "提示", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let okCallaction = UIAlertAction(title: "確定", style: .default) { (action) in
            submit?()
        }
        
        let cancelCallaction = UIAlertAction(title: "取消", style: .default) { (action) in
            cancel?()
        }
        
        alert.addAction(okCallaction)
        alert.addAction(cancelCallaction)
        controller.present(alert, animated: true, completion: nil)
    }
}
