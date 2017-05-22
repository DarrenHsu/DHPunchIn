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
    
    private var loading: CircleLoading!
    private var loadingSuperView: UIView!
    private var loadingLabel: UILabel!
    
    public func startLoading(_ view: UIView) {
        loadingSuperView = UIView(frame: view.bounds)
        
        loadingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        loadingLabel.center = loadingSuperView.center
        loadingSuperView.addSubview(loadingLabel)
        
        loading = CircleLoading(frame: CGRect(x: 0, y: 0, width: 130, height: 130))
        loading.colors(color1: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), color2: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), color3: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        loading.center = loadingSuperView.center
        loading.start()
        
        loadingSuperView.addSubview(loading)
        
        view.addSubview(loadingSuperView)
    }
    
    public func stopLoading() {
        loading.stop()
        loadingSuperView.removeFromSuperview()
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
        
        alert.addAction(cancelCallaction)
        alert.addAction(okCallaction)
        controller.present(alert, animated: true, completion: nil)
    }
}
