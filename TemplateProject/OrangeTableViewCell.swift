//
//  OrangeTableViewCell.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/6/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class OrangeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var checkedButton: UIButton!
    
    var checked: Bool?
    
    var task: ATask? {
        didSet {
            if let task = task, taskLabel = taskLabel, endDateLabel = endDateLabel {
                taskLabel.text = task.taskContent
                endDateLabel.text = task.endDateContent
            }
        }
    }
    
    @IBAction func checkedButtonTapped(sender: AnyObject) {
        if !checked! {
            checkedButton.setImage(UIImage(named: "checked_box"), forState: .Normal)
            checked = true
        }
        else {
            checkedButton.setImage(UIImage(named: "unchecked_box"), forState: .Normal)
            checked = false
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

