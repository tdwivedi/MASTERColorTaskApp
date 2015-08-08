//
//  NewTaskViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/5/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Mixpanel

class NewTaskViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var endDateTextField: UITextField!
    
    var currentTask:RTask!

    @IBAction func addButtonTapped(sender: AnyObject) {
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Add Red button tapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskTextField.delegate = self
        self.endDateTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
