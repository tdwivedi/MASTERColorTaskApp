//
//  RedViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/5/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class RedViewController: UIViewController {

    @IBOutlet weak var groupName: UILabel!
    
    @IBOutlet weak var redTableView: UITableView!
    
    var aaaGroupName = "Right Away"
    var newTaskName = ""
    var newEndDate = ""
    
    var selectedTask:RTask!
    
    var tasks: Results<RTask>! {
        didSet {
            // Whenever notes update, update the table view
            redTableView?.reloadData()
        }
    }
    
    //var group: AGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            case "Back":
                println("do nothing")
            default:
                println("o k")
            }
            tasks = realm.objects(RTask)
        }
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

extension RedViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as! RedTableViewCell
        
        let row = indexPath.row
        let task = tasks[row] as RTask
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTask = tasks[indexPath.row]
    }
    
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
