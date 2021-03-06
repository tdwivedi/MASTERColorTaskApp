//
//  OrangeViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/6/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift
import Mixpanel

class OrangeViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var groupName: UILabel!
    
    @IBOutlet weak var orangeTableView: UITableView!
    
    var aaaGroupName = "Coming Up"
    var newTaskName = ""
    var newEndDate = ""
    var isChecked: Bool!
    
    var selectedTask:OTask!
    
    var Otasks: Results<OTask>! {
        didSet {
            // Whenever notes update, update the table view
            orangeTableView?.reloadData()
        }
    }
    
    @IBAction func newButtonTapped(sender: AnyObject) {
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("New Orange button tapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupName.text = aaaGroupName
        orangeTableView.dataSource = self
        orangeTableView.delegate = self
        self.orangeTableView.estimatedRowHeight = 77
        self.orangeTableView.rowHeight = UITableViewAutomaticDimension
        //let realm = Realm()
        /*realm.write() {
        realm.add(self.aaaGroupName) //currentTask
        }*/
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.orangeTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        let realm = Realm()
        /*group.groupName = aaaGroupName
        realm.write() {
        realm.add(self.group)
        }*/
        Otasks = realm.objects(OTask)
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //selectedTask = Otasks[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("OrangeTaskCell", forIndexPath: indexPath) as! OrangeTableViewCell
        
        var row = indexPath.row
        let task = Otasks[row] as OTask
        cell.task = task
        
        newTaskName = cell.taskLabel.text!
        newEndDate = cell.endDateLabel.text!
        isChecked = cell.task?.isDone
        
        performSegueWithIdentifier("ShowOrangeTask", sender: self)
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            let realm = Realm()
            switch identifier {
            case "OrangeAdd":
                let source = segue.sourceViewController as! OrangeNewTaskViewController
                newTaskName = source.taskTextField.text
                newEndDate = source.endDateTextField.text
                
                source.currentTask = OTask()
                source.currentTask.taskContent = source.taskTextField.text
                source.currentTask.endDateContent = source.endDateTextField.text
                realm.write {
                    realm.add(source.currentTask!)
                }
            case "OrangeBack":
                println("do nothing")
            default:
                println("o k")
            }
            Otasks = realm.objects(OTask)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowOrangeTask" {
            let destination = segue.destinationViewController as! OrangeTaskDisplayViewController
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

extension OrangeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OrangeTaskCell", forIndexPath: indexPath) as! OrangeTableViewCell
        
        let row = indexPath.row
        let task = Otasks[row] as OTask
        cell.task = task
        
        if task.isDone {
            cell.checkedButton.setImage(UIImage(named: "checked_box"), forState: .Normal)
        }
        else {
            cell.checkedButton.setImage(UIImage(named: "unchecked_box"), forState: .Normal)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(Otasks?.count ?? 0)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 77
    }
    
}

extension OrangeViewController: UITableViewDelegate {
    
    /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTask = Otasks[indexPath.row]
    }*/
    
    // 3
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // 4
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let task = Otasks[indexPath.row] as OTask
            
            let realm = Realm()
            
            realm.write() {
                realm.delete(task)
            }
            
            Otasks = realm.objects(OTask)
        }
    }
    
}
