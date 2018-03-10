//
//  ConnectAccountsController.swift
//  Frame
//
//  Created by Matthew Paletta on 2018-03-10.
//  Copyright © 2018 Matthew Paletta. All rights reserved.
//

import UIKit

class ConnectAccountsController: UIViewController {
    @IBOutlet weak var IconStack: UIStackView!
    
    @IBOutlet weak var FBButton: UIButton!
    @IBOutlet weak var InstButton: UIButton!
    
    @IBOutlet weak var finishButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
