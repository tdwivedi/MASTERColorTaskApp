//
//  YTask.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/7/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import RealmSwift

class YTask: Object { //Object (for realm)
    
    dynamic var taskContent = ""
    dynamic var endDateContent = ""
    dynamic var isDone = false
    
}
