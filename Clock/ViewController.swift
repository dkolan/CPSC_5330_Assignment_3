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
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var speed : Float = 1.0
    var timeLeft : Int?
    var estimatedTime : Int?
    var timer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        assignbackground("daytimeBackground")
        
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
        
        formatter.dateFormat = "a"

        formatter.string(from: Date()) == "AM" ? setBackgroundImage("daytimeBackground") :
            setBackgroundImage("nighttimeBackground")
    }
    
    func setBackgroundImage (_ imageName : String) {
        backgroundImage.image = UIImage(named: imageName)
    }
    
    func assignbackground(_ background : String){
            let background = UIImage(named: background)

            var imageView : UIImageView!
            imageView = UIImageView(frame: view.bounds)
            imageView.contentMode =  UIView.ContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = background
            imageView.center = view.center
            view.addSubview(imageView)
            self.view.sendSubviewToBack(imageView)
    }
    
}

