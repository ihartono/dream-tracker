//
//  RegisterViewController.swift
//  DreamTracker
//
//  Created by Nakama on 16/11/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var labelFormMessage: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.btnRegister.layer.cornerRadius = 3
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        print("register click")
        
        if let name = nameTextField.text,
            let email = emailTextField.text,
            let pass = passwordTextField.text,
            let confirm = passwordConfirmTextField.text,
            !name.isEmpty,
            !email.isEmpty,
            !pass.isEmpty,
            !confirm.isEmpty {
            
            if pass != confirm {
                print("if pass != confirm")
                labelFormMessage.text = "Konfirmasi Password Salah"
                return;
            }
            print("setelah if pass != confirm")
            Alamofire
                .request(URL(string: "http://93.188.167.250:8080/register")!,
                         method: .post,
                         parameters: [
                            "name": nameTextField.text ?? "",
                            "email": emailTextField.text ?? "",
                            "password": passwordTextField.text ?? ""],
                         encoding: JSONEncoding.default)
                .responseJSON { (response) in
//                    print("alamofire response")
//                    print(response)
                    switch response.result {
                    case .success(let value):
                        print(value)
                        break;
                    case .failure(let error):
                        print(error)
                        break;
                    }
                    
            }
            
            labelFormMessage.text = ""
        } else {
            labelFormMessage.text = "Semua data harus diisi"
        }
    }
    
    @IBAction func tapRegisterButton(_ sender: UIBarButtonItem) {
        
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
