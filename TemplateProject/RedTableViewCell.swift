//
//  RedTableViewCell.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/5/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class RedTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var endDateLabel: UILabel!
    
    var task: ATask? {
        didSet {
            if let task = task, taskLabel = taskLabel, endDateLabel = endDateLabel {
                taskLabel.text = task.taskContent
                endDateLabel.text = task.endDateContent
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
