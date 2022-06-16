//
//  ReiceveTaskViewController.swift
//  SPEAKFUCKINGAPP
//
//  Created by eleonora elefante on 21/11/2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit
import AVFoundation


class ReiceveTaskViewController: UIViewController {
    var motionManager = CMMotionManager()
    var currentPlayer = 0
    let device = UIDevice()

    @IBOutlet weak var nav: UINavigationItem!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var payAttention: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var revealButton: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//create "person" as the first object of players, after the label displayed in the view takes the name of person
    let person = players[0]
    playerName.text = person.name
   
    revealButton.isUserInteractionEnabled = true
    revealButton.isHidden = false
    taskLabel.isHidden = false
    payAttention.isHidden = true
        
    revealsTask(self)
        
        
    //navigationController?.isNavigationBarHidden = true
       
    
   }
//when the button is tapped the button "disappears" and the label is shown + call the function to get the task
   @IBAction func revealsTask(_ sender: Any) {
       if revealButton.isTouchInside == true {
          revealButton.isHidden = true
          taskLabel.isHidden = false
          gyroscope()
        }
        else {
          revealButton.isHidden = false
          taskLabel.isHidden = true
        }
        takeTask()
    }
//starting from the first element of the array and basing on the level, the label will take the text randomly from the related array
    func takeTask() {
        
        if players[currentPlayer].level == "Beginner" {
            players[currentPlayer].task = beginner.randomElement()
            taskLabel.text = players[currentPlayer].task
        }
        else if players[currentPlayer].level == "Intermediate" {
            players[currentPlayer].task = intermediate.randomElement()
            taskLabel.text = players[currentPlayer].task
        }
        else {
            players[currentPlayer].task = advanced.randomElement()
            taskLabel.text = players[currentPlayer].task
        }
       //print(currentPlayer)
       //print(players)
    }
    
//everytime I call the function I add 1 to the var currentPlayer and:
//if this var is less then the element cointained in players the label playerName take the text from the name of element with the index = to currentPlayer and call the function "nextPlayer"
//else go to the next screen
    @IBAction func nextTask(_ sender: Any) {
        
        currentPlayer += 1
        if currentPlayer < players.count {
             playerName.text = players[currentPlayer].name
             nextPlayer()
        }
        else {
             performSegue(withIdentifier: "goToCommonTopic", sender: self)
            }
      }
    
    func nextPlayer() {
        revealButton.isHidden = false
        taskLabel.isHidden = true
        takeTask()
        
  }
        override func prepare(for: UIStoryboardSegue, sender: Any?){
        
    }
      func gyroscope() {
//this function depending on the inclination(pitch) of the device ("if shake.."):
//shows an imageView (payAttention)
//makes the device vibrates
//I'll call this function only when the task is shown
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!){
                 (data, error) in
                    
        if let myData = data {
            let shake = myData.attitude
            
          if shake.pitch < 0.60 {
            self.payAttention.isHidden = false
            self.taskLabel.isHidden = true
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            print("statt accort")
            
          } else {
            self.taskLabel.isHidden = false
            self.payAttention.isHidden = true
            
            }
          }
       }
    }
    override func viewDidDisappear(_ animated: Bool) {
        motionManager.stopDeviceMotionUpdates()
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        nextButton.isOpaque = true 
    }
    
}

       
