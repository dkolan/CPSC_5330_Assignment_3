//
//  ViewController.swift
//  Clock
//
//  Created by Dan Kolan on 1/20/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.setValue(UIColor.lightGray.withAlphaComponent(0.25), forKey: "backgroundColor")
    }


}

