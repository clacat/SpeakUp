//
//  ConversationStarterViewController.swift
//  SPEAKFUCKINGAPP
//  Created by eleonora elefante on 21/11/2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import Foundation
import UIKit


class ConversationStarterViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var startButton: UIButton!
    @IBAction func skipThisTask(_ sender: Any) {
        globalTopic = conversationStarters.randomElement()!
        conversationStarter.text = globalTopic
    }
    
    @IBOutlet weak var conversationStarter: UILabel!
    
        override func viewDidLoad() {   
        super.viewDidLoad()
        
        //navigationController?.isNavigationBarHidden = true 
        globalTopic = conversationStarters.randomElement()!
        conversationStarter.text = globalTopic
            
        
    }
    @IBAction func startTapped(_ sender: Any) {
        startButton.isOpaque = true
    }
    
}
