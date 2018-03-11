//
//  ViewController.swift
//  Frame
//
//  Created by Matthew Paletta on 2018-03-10.
//  Copyright © 2018 Matthew Paletta. All rights reserved.
//

import UIKit
import FacebookLogin

struct Employee: Codable {
    var name: String
    var id: Int
}

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var SetupButton: UIButton!
    @IBOutlet weak var IconStack: UIStackView!
    @IBOutlet weak var memoriesLabel: UILabel!
    
    @IBOutlet weak var codeGroup: UIStackView!
    
    
    @IBOutlet weak var code1: UITextField!
    @IBOutlet weak var code2: UITextField!
    @IBOutlet weak var code3: UITextField!
    @IBOutlet weak var code4: UITextField!
    
    
    
    var didHitSetup = false
    var current_code = ""
    
    var text_boxes: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.codeGroup.alpha = 0.0
        self.codeLabel.alpha = 0.0
        
        
        self.SetupButton.layer.cornerRadius = 8
        self.text_boxes = [self.code1, self.code2, self.code3, self.code4]
        
        for txt in self.text_boxes {
            txt.delegate = self
            txt.keyboardType = .numberPad
            txt.font = UIFont(name: "Helvetica", size: 30)
            txt.layer.cornerRadius = 8
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didBeginEditing(_ sender: UITextField) {
        let this_txt_index = self.text_boxes.index(of: sender)
        
        print("Did Begin Editing! \(this_txt_index)")
        
        if let index = this_txt_index, self.current_code.count != index {
            sender.resignFirstResponder()
            self.text_boxes[self.current_code.count].becomeFirstResponder()
            
            // Move text over
            for txt in self.text_boxes {
                let txt_index = self.text_boxes.index(of: sender)
                if let index = txt_index, index <= self.current_code.count {
                    let index2 = self.current_code.index(self.current_code.startIndex, offsetBy: index)
                    //txt.text = String(self.current_code[index2])
                } else {
                    //txt.text = ""
                }
                
                
            }
        }
        
    }
    

    @IBAction func editChanged(_ sender: UITextField) {
        print("Editing Changed!")
        self.current_code = ""
        for txt in self.text_boxes {
            if let tmp = txt.text, tmp != "" {
                print("Adding Character!")
                self.current_code.append(tmp)
            }
        }
        
        
        print("Current Code: \(self.current_code)")
        self.moveTextField()
        if self.current_code.count >= 4 {
            sender.resignFirstResponder()
            self.sendVerificationCode()
            self.performSegue(withIdentifier: "connectAccounts", sender: self)
        }
    }
    
    func sendVerificationCode() {
        UserDefaults.standard.set(self.current_code, forKey: "current_code")
        
        let url = URL(string: GCLOUD_SERVER + "/code_verified")
        
        var verifyCodeURLRequest = URLRequest(url: url!)
        verifyCodeURLRequest.httpMethod = "POST"
        verifyCodeURLRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        verifyCodeURLRequest.httpBody = try? JSONSerialization.data(withJSONObject: ["code": self.current_code], options: [])
        
        let task = URLSession.shared.dataTask(with: verifyCodeURLRequest, completionHandler: { (data, _, error) in
            guard error == nil else { return }
            
            if let jsonData = data, let data2 = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
                // TODO:// Error handling
            }
        })
        task.resume()
        
        /*
        url = URL(string: GCLOUD_SERVER + "/store_token")
        
        verifyCodeURLRequest = URLRequest(url: url!)
        verifyCodeURLRequest.httpMethod = "POST"
        verifyCodeURLRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        verifyCodeURLRequest.httpBody = try? JSONSerialization.data(withJSONObject: ["code": self.current_code, "token": "TIS THE TOKEN"], options: [])
        
        task = URLSession.shared.dataTask(with: verifyCodeURLRequest, completionHandler: { (data, response, error) in
            guard error == nil else { return }
        })
        task.resume()
        */
        
        /*
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            
            guard let data = data, error == nil else { return }
            let jsonDecoder = JSONDecoder()
            
            do {
                let jsonData = try jsonDecoder.decode(Employee.self, from: data)
                print(jsonData)
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
        */
    }
    
    
    func moveTextField() {
        
        let current_index = self.current_code.count - 1
        if current_index == -1 {
            return
        }
        
        print("Current Index: \(current_index)")
        let lastTextBox: UITextField = self.text_boxes[current_index]
        lastTextBox.resignFirstResponder()
        
        if current_index + 1 < self.text_boxes.count {
            let nextTextBox: UITextField = self.text_boxes[current_index + 1]
            nextTextBox.becomeFirstResponder()
        }
        
    }
    
    @IBAction func hitSetupButton(_ sender: Any) {
        self.didHitSetup = true
        
        UIView.animate(withDuration: 1, animations: {
            // Remove setup button
            self.SetupButton.alpha = 0.0
            self.memoriesLabel.alpha = 0.0
            
            // Move the icon up
            self.IconStack.center = CGPoint(x: self.IconStack.center.x, y: 77 + (self.IconStack.frame.height / 2) )
            
            // Display Numbers and keyboard
            self.codeGroup.alpha = 1.0
            self.codeLabel.alpha = 1.0
            }) { (error) in
                self.SetupButton.isEnabled = false
                self.SetupButton.isHidden = true
        }
        
    }
    
    // Segue: 'connectAccounts'
    


}

