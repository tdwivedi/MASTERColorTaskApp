//
//  HomeViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/4/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var toDoLabel: UILabel!
    
    @IBOutlet weak var redButton: UIButton!
    
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var yellowGreenButton: UIButton!
    @IBOutlet weak var lightGreenButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var darkGreenButton: UIButton!
    @IBOutlet weak var tealButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    var newChosenColor = ""
    var newGroupName = ""
    var groupToDelete = ""
    
    var selectedGroup:AGroup!
    
    var groups: Results<AGroup>! {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let realm = Realm()
        // Do any additional setup after loading the view.
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
                let source = segue.sourceViewController as! NewGroupViewController
                newChosenColor = source.chosenColor
                newGroupName = source.groupNameTextField.text
                
                //write?!
                realm.write {
                    realm.add(source.currentGroup)
                }
                
                println(newChosenColor)
                println(newGroupName)
            case "Back":
                println("do nothing")
            case "Delete":
                let source = segue.sourceViewController as! DeleteGroupViewController
                groupToDelete = source.deleteGroupTextField.text
                
            default:
                println("o k")
            }
            groups = realm.objects(AGroup)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Red" {
            if newChosenColor == "Red" {
                let destination = segue.destinationViewController as! RedViewController
                destination.aaaGroupName = newGroupName
                //destination.groupName.text = newGroupName
                destination.aaaGroupName = newGroupName
                let realm = Realm()
                destination.group = AGroup()
                destination.aaaGroupName = newGroupName
                destination.group.groupName = newGroupName
                realm.write() {
                    realm.add(destination.group)
                }
            }
        }
        if segue.identifier == "Orange" {
            if newChosenColor == "Orange" {
                let destination = segue.destinationViewController as! OrangeViewController
                destination.aaaGroupName = newGroupName
                //destination.groupName.text = newGroupName
                destination.aaaGroupName = newGroupName
                let realm = Realm()
                destination.group = AGroup()
                destination.aaaGroupName = newGroupName
                destination.group.groupName = newGroupName
                realm.write() {
                    realm.add(destination.group)
                }
            }
        }
        if segue.identifier == "Yellow" {
            
        }
        if segue.identifier == "Yellow-Green" {
            
        }
        if segue.identifier == "Green" {
            
        }
        if segue.identifier == "Dark Green" {
            
        }
        if segue.identifier == "Teal" {
            
        }
        if segue.identifier == "Blue" {
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
