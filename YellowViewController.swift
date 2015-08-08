//
//  YellowViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/6/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift
import Mixpanel

class YellowViewController: UIViewController {
    
    @IBOutlet weak var groupName: UILabel!
    
    @IBOutlet weak var yellowTableView: UITableView!
    
    var aaaGroupName = "In the Future"
    var newTaskName = ""
    var newEndDate = ""
    
    var selectedTask:YTask!
    
    var Ytasks: Results<YTask>! {
        didSet {
            // Whenever notes update, update the table view
            yellowTableView?.reloadData()
        }
    }
    
    @IBAction func newButtonTapped(sender: AnyObject) {
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("New Yellow button tapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupName.text = aaaGroupName
        yellowTableView.dataSource = self
        yellowTableView.delegate = self
        self.yellowTableView.estimatedRowHeight = 77
        self.yellowTableView.rowHeight = UITableViewAutomaticDimension
        //let realm = Realm()
        /*realm.write() {
        realm.add(self.aaaGroupName) //currentTask
        }*/
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.yellowTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        let realm = Realm()
        /*group.groupName = aaaGroupName
        realm.write() {
        realm.add(self.group)
        }*/
        Ytasks = realm.objects(YTask)
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
            case "YellowAdd":
                let source = segue.sourceViewController as! YellowNewTaskViewController
                newTaskName = source.taskTextField.text
                newEndDate = source.endDateTextField.text
                
                source.currentTask = YTask()
                source.currentTask.taskContent = source.taskTextField.text
                source.currentTask.endDateContent = source.endDateTextField.text
                realm.write {
                    realm.add(source.currentTask!)
                }
            case "YellowBack":
                println("do nothing")
            default:
                println("o k")
            }
            Ytasks = realm.objects(YTask)
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

extension YellowViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("YellowTaskCell", forIndexPath: indexPath) as! YellowTableViewCell
        
        let row = indexPath.row
        let task = Ytasks[row] as YTask
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
        return Int(Ytasks?.count ?? 0)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 77
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

extension YellowViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTask = Ytasks[indexPath.row]
    }
    
    // 3
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // 4
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let task = Ytasks[indexPath.row] as YTask
            
            let realm = Realm()
            
            realm.write() {
                realm.delete(task)
            }
            
            Ytasks = realm.objects(YTask)
        }
    }
    
}
