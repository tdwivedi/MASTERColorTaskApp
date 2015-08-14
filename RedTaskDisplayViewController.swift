//
//  RedTaskDisplayViewController.swift
//  Tackle
//
//  Created by Trisha Dwivedi on 8/11/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class RedTaskDisplayViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    var currentStatus: String!
    
    @IBOutlet weak var taskContentLabel: UILabel!
    var taskText: String!
    
    @IBOutlet weak var endDateLabel: UILabel!
    var endDate: String!
    
    //@IBOutlet weak var notesTextView: UITextView!
    //var notesText: String!
    
    var currentCurrentTask: RTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //notesTextView.delegate = self
        //notesTextView.layer.borderWidth = 1
        //notesTextView.layer.borderColor = UIColor.grayColor().CGColor
        
        taskContentLabel.text = taskText
        endDateLabel.text = endDate
        
        statusLabel.text = currentStatus
        if statusLabel.text == "Not Done" {
            statusLabel.textColor = UIColor.redColor()
        } else {
            statusLabel.textColor = UIColor.greenColor()
        }
        
        //notesTextView.text = notesText
        
        
//        Realm().write {
//            self.currentCurrentTask.extraNotes = self.notesTextView.text
//            Realm().add(self.currentCurrentTask)
//        }
        
        /*var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)*/
        // Do any additional setup after loading the view.
    }
    
    /*func DismissKeyboard() {
        notesTextView.endEditing(true)
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
