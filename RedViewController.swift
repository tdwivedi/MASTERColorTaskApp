//
//  RedViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/5/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift
import Mixpanel

class RedViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var groupName: UILabel!
    
    @IBOutlet weak var redTableView: UITableView!
    
    //add properties that are in cell to use for prepare for segue to display
    var aaaGroupName = "Right Away"
    var newTaskName: String!
    var newEndDate: String!
    var isChecked: Bool!
    
    var selectedTask:RTask!
    
    var tasks: Results<RTask>! {
        didSet {
            // Whenever notes update, update the table view
            redTableView?.reloadData()
        }
    }
    
    @IBAction func newButtonTapped(sender: AnyObject) {
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("New Red button tapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //redTableView.separatorStyle = UITableViewCellSeparatorStyleNone
        
        groupName.text = aaaGroupName
        redTableView.dataSource = self
        redTableView.delegate = self
        redTableView.estimatedRowHeight = 77
        redTableView.rowHeight = UITableViewAutomaticDimension
        //self.redTableView.reloadData()
        //let realm = Realm()
        /*realm.write() {
            realm.add(self.aaaGroupName) //currentTask
        }*/
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        redTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        let realm = Realm()
        /*group.groupName = aaaGroupName
        realm.write() {
            realm.add(self.group)
        }*/
        tasks = realm.objects(RTask)
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            let realm = Realm()
            switch identifier {
            case "Add":
                let source = segue.sourceViewController as! NewTaskViewController
                newTaskName = source.taskTextField.text
                newEndDate = source.endDateTextField.text
                
                source.currentTask = RTask()
                source.currentTask.taskContent = source.taskTextField.text
                source.currentTask.endDateContent = source.endDateTextField.text
                realm.write {
                    realm.add(source.currentTask!)
                }
            case "BackToRed":
                let source = segue.sourceViewController as! RedTaskDisplayViewController
                
            case "Back":
                println("do nothing")
            default:
                println("o k")
            }
            tasks = realm.objects(RTask)
        }
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //selectedTask = tasks[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as! RedTableViewCell
        
        var row = indexPath.row
        let task = tasks[row] as RTask
        cell.task = task
        
        newTaskName = cell.taskLabel.text!
        newEndDate = cell.endDateLabel.text!
        isChecked = cell.task?.isDone
        
        performSegueWithIdentifier("ShowRedTask", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowRedTask" {
            let destination = segue.destinationViewController as! RedTaskDisplayViewController
            destination.taskText = newTaskName
            destination.endDate = newEndDate
            
            //destination.currentCurrentTask = selectedTask
            /*Realm().write {
                destination.notesTextView.text
            }*/
            if isChecked == false {
                destination.currentStatus = "Not Done"
            }
            else {
                destination.currentStatus = "Finished"
            }
        }
    }


}

extension RedViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as! RedTableViewCell
        
        let row = indexPath.row
        let task = tasks[row] as RTask
        cell.task = task
        //cell.task?.extraNotes =
        
        if task.isDone {
            cell.checkedButton.setImage(UIImage(named: "checked_box"), forState: .Normal)
        }
        else {
            cell.checkedButton.setImage(UIImage(named: "unchecked_box"), forState: .Normal)
        }
        
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(tasks?.count ?? 0)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 77
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

extension RedViewController: UITableViewDelegate {
    
    /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //selectedTask = tasks[indexPath.row]
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as! RedTableViewCell
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! RedTableViewCell
        
        var row = indexPath.row
        let task = tasks[row] as RTask
        cell.task = task
        
        newTaskName = cell.taskLabel.text!
        newEndDate = cell.endDateLabel.text!
        isChecked = cell.task!.isDone
        
        performSegueWithIdentifier("ShowRedTask", sender: self)
    }*/
    
    // 3
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // 4
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let task = tasks[indexPath.row] as RTask
            
            let realm = Realm()
            
            realm.write() {
                realm.delete(task)
            }

            tasks = realm.objects(RTask)
        }
    }
    
}
