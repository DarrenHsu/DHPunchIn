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

    @IBOutlet weak var menuTableView : UITableView?

    var functionName : [String] = ["取得圖片","員工註冊"]
    var functionImage : [String] = ["ic_font_download","ic_add_to_photos"]

    override func viewDidLoad() {
        super.viewDidLoad()

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
        var controller : BaseViewController?
        switch (indexPath as NSIndexPath).row {
        case 0:
            break
        default:
            break
        }

        SlideNavigationController.sharedInstance()!.popAllAndSwitch(to: controller, withSlideOutAnimation: false, andCompletion: nil);
    }

}
