//
//  YellowNewTaskViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/6/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class YellowNewTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var endDateTextField: UITextField!
    
    var currentTask:YTask!
    
    /*// MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }*/
    
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
