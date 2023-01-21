//
//  ViewController.swift
//  Clock
//
//  Created by Dan Kolan on 1/20/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    
    var speed : Float = 1.0
    var timeLeft : Int?
    var estimatedTime : Int?
    var timer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        timeRemainingLabel.text = "Time Remaining:"
        
        getCurrentTime()
    }

    @IBAction func startTimer(_ sender: Any) {
        print(datePicker.countDownDuration)
    }
    
    private func getCurrentTime() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(self.currentTime) , userInfo: nil, repeats: true)
    }
    
    @objc func currentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        dateTime.text = formatter.string(from: Date())
    }
    
}

