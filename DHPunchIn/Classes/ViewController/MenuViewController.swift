//
//  MenuViewController.swift
//  iEnglish
//
//  Created by Dareen Hsu on 12/21/15.
//  Copyright © 2015 D.H. All rights reserved.
//

import UIKit

class MenuTableViewCell : UITableViewCell {
    @IBOutlet weak var functionNameLabel : UILabel?
    @IBOutlet weak var functionImageView : UIImageView?
}

class MenuViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var statusView : UIView?
    @IBOutlet weak var menuTableView : UITableView?

    var functionName : [String] = ["現在位置","打卡","員工資訊"]
    var functionImage : [String] = ["ic_map","ic_punch_card","ic_staff"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView?.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDataSource Methos
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functionName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! MenuTableViewCell

        cell.functionNameLabel!.text = functionName[(indexPath as NSIndexPath).row]
        cell.functionImageView?.image = UIImage.init(named: functionImage[(indexPath as NSIndexPath).row])
        
        return cell
    }

    // MARK: - UITableDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var controller: BaseViewController?
        switch (indexPath as NSIndexPath).row {
        case 1:
            controller = storyboard?.instantiateViewController(withIdentifier: "PunchInViewController") as! PunchInViewController
            break
        case 2:
            controller = storyboard?.instantiateViewController(withIdentifier: "StaffSignViewController") as! StaffSignViewController
            break
        default:
            controller = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        }
        
        controller?.title = functionName[(indexPath as NSIndexPath).row]
        SlideNavigationController.sharedInstance()!.popAllAndSwitch(to: controller, withSlideOutAnimation: false, andCompletion: nil);
    }

}
