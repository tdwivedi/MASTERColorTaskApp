//
//  NewGroupViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/4/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class NewGroupViewController: UIViewController {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    
    @IBOutlet weak var groupColorPickerView: UIPickerView!
    
    var colors = ["Red","Orange","Yellow","Yellow-Green","Green","Dark Green","Teal","Blue"]
    
    var chosenColor = ""
    
    var currentGroup:AGroup!

    override func viewDidLoad() {
        super.viewDidLoad()
        groupColorPickerView.delegate = self
        groupColorPickerView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

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

extension NewGroupViewController: UIPickerViewDelegate {
    //rowheight &
    //rowwidth methods
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String
    {
        return colors[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        chosenColor = colors[row]
        println(chosenColor)
    }
    
}

extension NewGroupViewController: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            return 9;
    }
    
}

