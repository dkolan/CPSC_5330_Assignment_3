//
//  ViewController.swift
//  Clock
//
//  Created by Dan Kolan on 1/20/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var startStopButton: UIButton!
    
    var speed : Float = 1.0
    var timeLeft : Int?
    var estimatedTime : Int?
    var clockTimer: Timer = Timer()
    var countdownTimer: Timer = Timer()
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Prepopulate assets that rely on timer.
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        dateTime.text = formatter.string(from: Date())
        formatter.dateFormat = "a"
        formatter.string(from: Date()) == "AM" ? setBackgroundImage("daytimeBackground") :
            setBackgroundImage("nighttimeBackground")
        startStopButton.setTitle("Start Timer", for: .normal)
        startStopButton.configuration?.baseForegroundColor = UIColor.black

        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        timeRemainingLabel.text = "Time Remaining:"
        
        getCurrentTime()
    }
    
    private func getCurrentTime() {
        clockTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(self.currentTime) , userInfo: nil, repeats: true)
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

    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    func printSecondsToHoursMinutesSeconds(_ seconds: Int) -> String {
        let (h, m, s) = secondsToHoursMinutesSeconds(seconds)
        return String(format: "%02d:%02d:%02d",h,m,s)
    }

    @IBAction func startTimer(_ sender: Any) {
        countdownTimer.invalidate()
        if (startStopButton.currentTitle == "Start Timer") {
            startStopButton.setTitle("Stop Music", for: .normal)
            timeLeft = Int(datePicker.countDownDuration)
            countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCountDown), userInfo: nil, repeats: true)
            timeRemainingLabel.text = "Time Remaining: \(printSecondsToHoursMinutesSeconds(Int(datePicker.countDownDuration)))"
        } else {
            player?.stop()
            startStopButton.setTitle("Start Timer", for: .normal)
        }
    }

    @objc func startCountDown() {
        if timeLeft! >= 0 {
            timeRemainingLabel.text = "Time Remaining: \(printSecondsToHoursMinutesSeconds(timeLeft!))"
            timeLeft! -= 1
        } else {
            countdownTimer.invalidate()
            playMusic()
        }
    }

    func playMusic() {
        if let asset = NSDataAsset(name:"ttte"){
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"mp3")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
