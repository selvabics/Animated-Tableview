//
//  ViewController.swift
//  Animate_tableview
//
//  Created by jayaraj on 10/05/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var scrollUp: Bool = true
    @IBOutlet var btnAdd: UIButton?
    @IBOutlet var topImageView: UIView?
    @IBOutlet var tableView: UITableView?
    @IBOutlet var imgProfile: UIButton?
    @IBOutlet var topViewHeight: NSLayoutConstraint?
    @IBOutlet var profileHeight: NSLayoutConstraint?
    @IBOutlet var lblTitle: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        btnAdd?.layer.cornerRadius = btnAdd!.bounds.height / 2
//        topImageView?.layer.masksToBounds = true
        topImageView?.layer.shadowColor = UIColor.gray.cgColor
        topImageView?.layer.shadowOpacity = 1
        topImageView?.layer.shadowOffset = CGSize.zero
        topImageView?.layer.shadowRadius = 5
//        topImageView?.backgroundColor = UIColor.white
    }
    
    @IBAction func btnOpen(_ sender: UIButton) {
        print("button is clicked")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell
        cell?.btnAction?.layer.masksToBounds = true
        cell?.btnAction?.layer.cornerRadius = cell!.btnAction!.bounds.height / 2
        cell?.btnAction?.layer.borderWidth = 0.5
        cell?.btnAction?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.btnImage?.layer.cornerRadius = 4
        cell?.btnImage?.layer.borderWidth = 0.5
        cell?.btnImage?.layer.borderColor = UIColor.lightGray.cgColor
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0.5
        if scrollUp {
            cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, -80, 0)
        }else{
            cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 80, 0)
        }
        
        UIView.animate(withDuration: 1, delay: 0, options: .allowUserInteraction, animations: {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let moreRowAction = TableViewRowAction(style: UITableViewRowActionStyle.default, title: "             ") { action, indexPath in
            // Action Block of more button.
        }
        
        moreRowAction.image = UIImage(named: "place_holder_black")
        moreRowAction.backgroundColor = UIColor(red: 252/255, green: 65/255, blue: 75/255, alpha: 1.0)
        
        
        
        let deleteRowAction = TableViewRowAction(style: UITableViewRowActionStyle.default, title: "             ") { action, indexPath in
            // Action Block of delete button.
            
        }
        
        deleteRowAction.backgroundColor = UIColor(red: 252/255, green: 65/255, blue: 75/255, alpha: 1.0)
        deleteRowAction.image = UIImage(named: "place_holder_1")
        
        return [deleteRowAction, moreRowAction]
    }
    
    func ripple(){
        let ripple = CATransition()
//        ripple.type = "rippleEffect"
//        ripple.type = "suckEffect"
//        ripple.type = "pageUnCurl"
//        ripple.type = "pageCurl"
//        ripple.type = "cube"
//        ripple.type = "alignedCube"
//        ripple.type = "cameraIris"
//        ripple.type = "cameraIrisHollowOpen"
//        ripple.type = "cameraIrisHollowClose"
//        ripple.type = "flip"
//        ripple.type = "rotate"
//        ripple.type = kCATransitionFromBottom
        ripple.duration = 2.0
        topImageView?.layer.add(ripple, forKey: nil)
    }
    
    // MARK: - ScrollView Delegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0)
        {
            scrollUp = true
        }else{
            scrollUp = false
        }
        if scrollView.contentOffset.y > 0{
            if self.topViewHeight?.constant != 64{
                
                self.profileHeight?.constant = 0
                self.topViewHeight?.constant = 64
                UIView.animate(withDuration: 0.9, delay: 0, options: .allowUserInteraction, animations: {
                    UIApplication.shared.statusBarStyle = .lightContent
                    self.topImageView?.backgroundColor = UIColor.black
                    self.lblTitle?.textColor = UIColor.white
                    self.topImageView?.alpha = 1
                    self.imgProfile?.alpha = 0
//                    self.ripple()
                    self.view.layoutIfNeeded()
                    self.view.updateConstraints()
                })
            }
            
        }else{
            if self.topViewHeight?.constant != 157{
                self.profileHeight?.constant = 67
                self.topViewHeight?.constant = 157
                
                UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                    UIApplication.shared.statusBarStyle = .default
                    self.topImageView?.backgroundColor = UIColor.white
                    self.lblTitle?.textColor = UIColor.black
                    self.imgProfile?.alpha = 1
                    self.topImageView?.alpha = 1
//                    self.ripple()
                    self.view.layoutIfNeeded()
                })
            }
            
        }
    }

}



class TableViewRowAction: UITableViewRowAction
{
    var image: UIImage?
    
    func _setButton(button: UIButton)  {
        
        if let image = image, let titleLabel = button.titleLabel {
            
            let labelString = NSString(string: titleLabel.text!)
            let titleSize = labelString.size(attributes: [NSFontAttributeName: titleLabel.font])
            button.tintColor = UIColor.white
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            button.imageEdgeInsets.right = -titleSize.width
        }
    }
}

