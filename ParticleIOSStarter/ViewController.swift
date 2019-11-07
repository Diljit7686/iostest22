//
//  ViewController.swift
//  ParticleIOSStarter
//
//  Created by Parrot on 2019-06-29.
//  Copyright © 2019 Parrot. All rights reserved.
//

import UIKit
import Particle_SDK

class ViewController: UIViewController {

    // MARK: User variables
    let USERNAME = "diljit7686@gmail.com"
    let PASSWORD = "89687Dil$"
    
    // MARK: Device
    let DEVICE_ID = "36001b001047363333343437"
    var myPhoton : ParticleDevice?
    
    @IBOutlet weak var timeLabel: UILabel!
    var timer: Timer?
    var runCount = 20
    var timeRunned = 20;
    @IBAction func StartTimer(_ sender: UIButton) {
        
        turnParticleGreen();
        
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        let displayLink = CADisplayLink(target: self, selector: #selector(fireTimer))
        displayLink.add(to: .current, forMode: .defaultRunLoopMode)
        
        
    //timer
        
        self.timeRunned = timeRunned - 1;
        // 1. Initialize the SDK
        ParticleCloud.init()
 
        // 2. Login to your account
        ParticleCloud.sharedInstance().login(withUser: self.USERNAME, password: self.PASSWORD) { (error:Error?) -> Void in
            if (error != nil) {
                // Something went wrong!
                print("Wrong credentials or as! ParticleCompletionBlock no internet connectivity, please try again")
                // Print out more detailed information
                print(error?.localizedDescription)
            }
            else {
                print("Login success!")
            }
        } // end login
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Get Device from Cloud
    // Gets the device from the Particle Cloud
    // and sets the global device variable
    func getDeviceFromCloud() {
    ParticleCloud.sharedInstance().getDevice(self.DEVICE_ID) { (device:ParticleDevice?, error:Error?) in
            
            if (error != nil) {
                print("Could not get device")
                print(error?.localizedDescription)
                return
            }
            else {
                print("Got photon: \(device?.id)")
                self.myPhoton = device
            }
            
        } // end getDevice()
    }
    
    
    //MARK: Subscribe to "playerChoice" events on Particle
//    func subscribeToParticleEvents() {
//        var handler : Any?
//        handler = ParticleCloud.sharedInstance().subscribeToDeviceEvents(
//            withPrefix: "playerChoice",
//            deviceID:self.DEVICE_ID,
//            handler: {
//                (event :ParticleEvent?, error : Error?) in
//
//                if let _ = error {
//                    print("could not subscribe to events")
//                } else {
//                    print("got event with data \(event?.data)")
//                    let choice = (event?.data)!
//                    if (choice == "A") {
//                      //  self.turnParticleGreen()
//                      //  self.gameScore = self.gameScore + 1;
//                    }
//                    else if (choice == "B") {
//                     //   self.turnParticleRed()
//                    }
//                }
//        })
//    }
    
    
    
    
    
    func turnParticleGreen() {
        
        print("Pressed the change lights button")
        
        let parameters = ["off"]
     var task = myPhoton!.callFunction("controlLights", withArguments: parameters) {
            (resultCode : NSNumber?, error : Error?) -> Void in
            if (error == nil) {
                print("Sent message to Particle to turn green")
                // self.correctOrNot.text = "CORRECT! WELL-DONE"
            }
            else {
                print("Error when telling Particle to turn green")
            }
        }
        
        
    }
    @objc func fireTimer() {
       // print("Timer fired!")
        runCount -= 1
        let str2 = String(runCount)
        timeLabel.text = str2
    
        if runCount == 0 {
            timer?.invalidate()
            
         
    }
    
    
    }
}

