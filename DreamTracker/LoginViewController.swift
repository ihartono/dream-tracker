//
//  LoginViewController.swift
//  DreamTracker
//
//  Created by Iwan Hartono on 21/11/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit
import Alamofire

struct loginResponse: Codable {
    let data: String?
    let error: String?
    let success: Int
}


class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var labelFormMessage: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.btnLogin.layer.cornerRadius = 3
    }
    
    @IBAction func tapLoginBtn(_ sender: Any) {
        if let email = emailTextField.text,
            let pass = passwordTextField.text,
            !email.isEmpty,
            !pass.isEmpty {
            
            Alamofire.request(URL(string: "http://93.188.167.250:8080/login")!,
                              method: .post,
                              parameters: [
                                "email": emailTextField.text ?? "",
                                "password": passwordTextField.text ?? ""],
                              encoding: JSONEncoding.default)
                .responseJSON { (response) in
                    switch response.result {
                    case .success(let JSON):
                        let res = JSON as! NSDictionary
                        let data = res.object(forKey: "data")!
                        let error = res.object(forKey: "error")!
                        let success = res.object(forKey: "success") as! Int
                        
                        if success == 1 {
                            //TODO get token value
                            let dt = data as! NSDictionary
                            _ = dt.object(forKey: "token")!
                            
                            UserDefaults.standard.setIsLoggedIn(value: true)
                            self.labelFormMessage.text = ""
                            
                            if UserDefaults.standard.isLoggedIn() {
                                self.transitionRightToLeft()
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                let controller = storyBoard.instantiateViewController(withIdentifier: "listIdentifier")
                                self.present(controller, animated: true, completion: nil)
                            }
                        }
                        else {
                            self.labelFormMessage.text = error as? String
                        }
                        
                        break;
                    case .failure(_ ):
                        self.labelFormMessage.text = "Network error. Please try again"
                        
                        let alert = UIAlertController(title: nil, message: "Gagal Login", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
                        self.present(alert, animated: true, completion: nil)
                        
                        break;
                    }
            }
        } else {
            labelFormMessage.text = "Please fill Email and Password"
        }
    }
    
    func transitionRightToLeft() {
        // https://stackoverflow.com/questions/37722323/how-to-present-view-controller-from-right-to-left-in-ios-using-swift
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
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
