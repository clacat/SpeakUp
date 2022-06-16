//  ViewController.swift
//  SPEAKFUCKINGAPP
//  Created by Claudia Catapano on 20/11/2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var runsFirstTime = true
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var howToPlayButton: UIButton!
    @IBAction func playTapped(_ sender: Any) {
        playButton.isOpaque = true
    }    
    @IBAction func howToPlayTapped(_ sender: Any) {
        howToPlayButton.isOpaque = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if !navigationController!.isNavigationBarHidden {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        //navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //navigationController?.isNavigationBarHidden = true 
        self.view.addSubview(playButton)
        self.view.addSubview(howToPlayButton)
    }
    override func viewDidDisappear(_ animated: Bool) {
        //navigationController?.isNavigationBarHidden = false
        if navigationController!.isNavigationBarHidden {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
   
}
