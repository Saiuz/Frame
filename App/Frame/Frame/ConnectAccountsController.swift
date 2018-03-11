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

class ConnectAccountsController: UIViewController, LoginButtonDelegate {
    
    @IBOutlet weak var IconStack: UIStackView!
    
    @IBOutlet weak var FBButton: UIButton!
    @IBOutlet weak var InstButton: UIButton!
    
    @IBOutlet weak var finishButton: UIButton!
    
    var current_code: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [.userPhotos])
        loginButton.center = view.center
        loginButton.delegate = self
        
        view.addSubview(loginButton)
        
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: "current_code") {
            self.current_code = stringOne
        }
        
        self.finishButton.layer.cornerRadius = 8
        
        // Do any additional setup after loading the view.
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        if let accessToken = AccessToken.current {
            print(accessToken.authenticationToken)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func connectFB(_ sender: Any) {
        
    }

    @IBAction func connectInst(_ sender: Any) {
        
        
    }
    
    @IBAction func didFinish(_ sender: Any) {
        
    }
    
    func sendToken(token: String) {
        
        let url = URL(string: "http://35.230.80.120:8080/token")
        
        var todosUrlRequest = URLRequest(url: url!)
        todosUrlRequest.httpMethod = "POST"
        todosUrlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            let dic = ["code": self.current_code, "token": token]
            let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: [])
            
            todosUrlRequest.httpBody = jsonData
            // See if it's right
            if let bodyData = todosUrlRequest.httpBody {
                print(String(data: bodyData, encoding: .utf8) ?? "no body data")
            }
        } catch {
            print(error)
            //completionHandler(nil, error)
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: todosUrlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                print(error)
                //completionHandler(nil, error!)
                return
            }
            
            print(String(data: data!, encoding: .utf8))
            
            if let jsonData = data, let data2 = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
                print("data!", data2)
            }
            
            print("Something Happened!")
            // TODO: parse response
            
            //completionHandler(nil, nil)
        })
        task.resume()
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
