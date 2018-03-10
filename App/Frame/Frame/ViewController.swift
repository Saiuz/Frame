//
//  ViewController.swift
//  Frame
//
//  Created by Matthew Paletta on 2018-03-10.
//  Copyright © 2018 Matthew Paletta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

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
        self.SetupButton.layer.cornerRadius = 8
        self.code1.delegate = self
        self.code1.keyboardType = .numberPad
        self.code2.delegate = self
        self.code2.keyboardType = .numberPad
        self.code3.delegate = self
        self.code3.keyboardType = .numberPad
        self.code4.delegate = self
        self.code4.keyboardType = .numberPad
        
        self.text_boxes = [self.code1, self.code2, self.code3, self.code4]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.current_code = ""
        for text: UITextField in self.text_boxes {
            if text.text != "" {
                self.current_code.append(text.text)
            }
        }
        
        self.moveTextField(textField: textField)
    }
    
    func moveTextField(textField: UITextField) {
        let current_index = self.current_code.count
        let lastTextBox: UITextField = self.text_boxes[current_index]
        lastTextBox.resignFirstResponder()
        
        if current_index < self.text_boxes.count {
            let nextTextBox: UITextField = self.text_boxes[current_index + 1]
            nextTextBox.becomeFirstResponder()
        }
        
    }
    
    
    
    @IBAction func hitSetupButton(_ sender: Any) {
        self.didHitSetup = true
        
        UIView.animate(withDuration: 2, animations: {
            // Remove setup button
            self.SetupButton.alpha = 0.0
            self.memoriesLabel.alpha = 0.0
            
            // Move the icon up
            self.IconStack.center = CGPoint(x: self.IconStack.center.x, y: 77 + (self.IconStack.frame.height / 2) )
            
            // Display Numbers and keyboard
            self.codeGroup.alpha = 1.0
            }) { (error) in
                self.SetupButton.isEnabled = false
                self.SetupButton.isHidden = true
        }
        
    }
    
    // Segue: 'connectAccounts'
    


}

