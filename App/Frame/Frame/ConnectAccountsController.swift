//
//  ConnectAccountsController.swift
//  Frame
//
//  Created by Matthew Paletta on 2018-03-10.
//  Copyright © 2018 Matthew Paletta. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ConnectAccountsController: UIViewController {
    
    @IBOutlet weak var IconStack: UIStackView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    var current_code: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = UIButton(type: .custom)
        loginButton.setTitle("Login with Facebook", for: UIControlState())
        loginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        loginButton.backgroundColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        loginButton.layer.cornerRadius = 8

        loginButton.frame = CGRect(origin: loginButton.frame.origin, size: CGSize(width: 260, height: 60))
        
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: "current_code") {
            self.current_code = stringOne
        }
        
        self.finishButton.layer.cornerRadius = 8
        
        // Do any additional setup after loading the view.
    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .userPhotos ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                if let accessToken = AccessToken.current {
                    let url = URL(string: GCLOUD_SERVER + "/store_token")
                    
                    var verifyCodeURLRequest = URLRequest(url: url!)
                    verifyCodeURLRequest.httpMethod = "POST"
                    verifyCodeURLRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                    verifyCodeURLRequest.httpBody = try? JSONSerialization.data(withJSONObject: ["code": self.current_code, "token": accessToken.authenticationToken], options: [])
                    
                    let task = URLSession.shared.dataTask(with: verifyCodeURLRequest, completionHandler: { (data, response, error) in
                        guard error == nil else { return }
                    })
                    task.resume()
                }
            }
        }
    }
    
    @IBAction func connectFB(_ sender: Any) {
        
    }

    @IBAction func connectInst(_ sender: Any) {
        
        
    }
    
    @IBAction func didFinish(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
