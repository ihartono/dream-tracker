//
//  ListViewController.swift
//  DreamTracker
//
//  Created by Iwan Hartono on 27/11/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit
import Alamofire

struct Dream : Decodable {
    let description: String
    let id : Int
    let title: String
}


class ListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        
        Alamofire.request(URL(string: "http://93.188.167.250:8080/me/dreams")!,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: [
                            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZlckBmZXIuY29tIiwiaWQiOiIxIiwibmFtZSI6IkZlcmljbyJ9.XvvHvQyP8YuukKtyXsohpe1-H1BY-pWb94kbtnIL5PQ"])
            .responseJSON { (response) in
                switch response.result {
                case .success(let JSON):
                    let res = JSON as! NSDictionary
                    let data = res.object(forKey: "data")!
                    let success = res.object(forKey: "success") as! Int
                    
                    if success == 1 {
                        let dataToArray = (data as! NSArray) as Array
                        print(dataToArray)
                        print("ahahahhahahahhahahhahhaha")
                        
                        dataToArray.forEach { eachDream in
                            let description = eachDream["description"] as? String ?? "empty description"
                            let id = eachDream["id"] as! Int
                            let image_uri = eachDream["image_uri"] as? String ?? "emptyimageuri"
                            let title = eachDream["title"] as? String ?? "empty title"
                            let todo = res.object(forKey: "todo") ?? "empty object"
                            let user_id = eachDream["user_id"] as! Int
                            
                            print(description)
                            print(id)
                            print(image_uri)
                            print(title)
                            print(todo)
                            print(user_id)
                        }
                    }
                    // TODO add condition when success is 0
                case .failure(_ ):
                    print("request failed")
                }
                
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        
        cell.textLabel?.text = "ahaha"
        
        return cell
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
