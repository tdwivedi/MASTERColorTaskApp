//
//  RedTableViewCell.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/5/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class RedTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var checkedButton: UIButton!
    
    var checked: Bool?
    
    var task: RTask? {
        didSet {
            if let task = task, taskLabel = taskLabel, endDateLabel = endDateLabel {
                taskLabel.text = task.taskContent
                endDateLabel.text = task.endDateContent
            }
        }
    }
    
    @IBAction func checkedButtonTapped(sender: AnyObject) {
        /*if !checked! {
            Realm().write {
                self.checkedButton.setImage(UIImage(named: "checked_box"), forState: .Normal)
                self.task?.isDone = true
            }
            checked = true
        }
        else {
            checkedButton.setImage(UIImage(named: "unchecked_box"), forState: .Normal)
            checked = false
            Realm().write {
                task?.isDone = false
            }
        }*/
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
