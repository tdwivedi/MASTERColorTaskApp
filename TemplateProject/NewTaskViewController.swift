//
//  NewTaskViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/5/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var endDateTextField: UITextField!
    
    var currentTask:ATask!

    /*// MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
