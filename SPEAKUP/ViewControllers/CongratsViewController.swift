//
//  CongratsViewController.swift
//  SPEAKFUCKINGAPP
//
//  Created by Alexey Antonov on 24/11/2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import UIKit

class CongratsViewController: UIViewController {
    @IBOutlet weak var namesTextField: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        namesTextField.text = "\(winners.joined(separator: ", "))!"
    }
    
    @IBAction func theEnd(_ sender: Any) {
        players.removeAll()
        winners.removeAll()
        globalTopic = ""
        time = 15
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
