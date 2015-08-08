//
//  YellowTableViewCell.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/6/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift
import Mixpanel

class YellowTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var checkedButton: UIButton!
    
    var checked: Bool?
    
    var task: YTask? {
        didSet {
            if let task = task, taskLabel = taskLabel, endDateLabel = endDateLabel {
                taskLabel.text = task.taskContent
                endDateLabel.text = task.endDateContent
            }
        }
    }
    
    @IBAction func checkedButtonTapped(sender: AnyObject) {
        /*if !checked! {
            checkedButton.setImage(UIImage(named: "checked_box"), forState: .Normal)
            checked = true
            Realm().write {
                task?.isDone = true
            }
        }
        else {
            checkedButton.setImage(UIImage(named: "unchecked_box"), forState: .Normal)
            checked = false
            Realm().write {
                task?.isDone = false
            }
        }*/
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Checkbox Yellow button tapped")
        if self.task?.isDone == false {
            Realm().write {
                self.checkedButton.setImage(UIImage(named: "checked_box"), forState: .Normal)
                self.task?.isDone = true
                Realm().add(self.task!)
            }
        }
        else {
            Realm().write {
                self.checkedButton.setImage(UIImage(named: "unchecked_box"), forState: .Normal)
                self.task?.isDone = false
                Realm().add(self.task!)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
