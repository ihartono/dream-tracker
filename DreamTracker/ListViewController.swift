//
//  ListViewController.swift
//  DreamTracker
//
//  Created by Iwan Hartono on 27/11/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("aaa")
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        print("logout clicked")
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        if !UserDefaults.standard.isLoggedIn() {
            transitionRightToLeft()
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "loginIdentifier")
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func transitionRightToLeft() {
        // https://stackoverflow.com/questions/37722323/how-to-present-view-controller-from-right-to-left-in-ios-using-swift
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
