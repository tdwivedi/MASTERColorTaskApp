//
//  HomeViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 8/4/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift
import Mixpanel

class HomeViewController: UIViewController {
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    
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
            switch identifier {
            case "Back":
                println("do nothing")
                
            default:
                println("o k")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Info" {
            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("Information button tapped")
        }
        if segue.identifier == "Red" {
            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("Red button tapped")
        }
        if segue.identifier == "Orange" {
            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("Orange button tapped")
        }
        if segue.identifier == "Yellow" {
            let mixpanel: Mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("Yellow button tapped")
        }
    }
    
}
