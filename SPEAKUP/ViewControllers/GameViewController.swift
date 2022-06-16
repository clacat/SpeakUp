//
//  GameViewController.swift
//  SPEAKFUCKINGAPP
//
//  Created by Alexey Antonov on 24.11.2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import UIKit
import SoundAnalysis
import AVFoundation
import AudioToolbox

class GameViewController: UIViewController, SRCountdownTimerDelegate {
    @IBOutlet weak var gameTimer: SRCountdownTimer!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    
    let audioEngine = AVAudioEngine()
    var lastLanguages = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        themeLabel.text = globalTopic
        
        gameTimer.useMinutesAndSecondsRepresentation = true
        gameTimer.delegate = self
        gameTimer.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.0)
        gameTimer.labelFont = UIFont(name: "Noteworthy-Bold", size: 48.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnalysis()
        
        gameTimer.start(beginingValue: time)
    }
    
    func startAnalysis() {
        let inputBus = AVAudioNodeBus(0)
        let inputFormat = audioEngine.inputNode.inputFormat(forBus: inputBus)
        let node = audioEngine.inputNode
        
        do {
            // Start the stream of audio data.
            try audioEngine.start()
        } catch {
            print("Unable to start AVAudioEngine: \(error.localizedDescription)")
        }
        
        let streamAnalyzer = SNAudioStreamAnalyzer(format: inputFormat)
        
        do {
            let request = try SNClassifySoundRequest(mlModel: LanguageClassifier().model)
            try streamAnalyzer.add(request, withObserver: self)
        } catch {
            print("Error")
        }
        
        let analysisQueue = DispatchQueue(label: "com.apple.AnalysisQueue")
        
        
        node.installTap(onBus: 0, bufferSize: 8192, format: inputFormat) { buffer, time in
            analysisQueue.async {
                streamAnalyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
            }
        }
    }
    
    @IBAction func cancelGame(_ sender: Any) {
        gameTimer.pause()
        let alert = UIAlertController(title: "ARE YOU SURE?", message: "Do you really want to stop the game?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .destructive, handler: { [unowned self] _ in
            players.removeAll()
            winners.removeAll()
            globalTopic = ""
            time = 15
            
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: nil))
        present(alert, animated: true, completion: { [unowned self] in
            self.gameTimer.resume()
        })
    }
    
    func timerDidEnd(sender: SRCountdownTimer, elapsedTime: TimeInterval) {
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        performSegue(withIdentifier: "winner", sender: nil)
    }
}

extension GameViewController: SNResultsObserving {
    func request(_ request: SNRequest, didProduce result: SNResult) {
          
          // Get the top classification.
          guard let result = result as? SNClassificationResult,
              let classification = result.classifications.first else { return }
          
            OperationQueue.main.addOperation {
                if classification.identifier == "Italian" {
                    if self.lastLanguages.count > 0 {
                        if self.lastLanguages.last == "Italian" {
                            //print("Don't speak italian!")
                            self.warningLabel.isHidden = false
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                            
                            self.lastLanguages.removeAll()
                        } else {
                            self.warningLabel.isHidden = true
                        }
                    }
                    
                } else {
                    self.lastLanguages.removeAll()
                    self.warningLabel.isHidden = true
                }
                //self.languageLabel.text = "\(classification.identifier)".capitalized
                print("\(classification.identifier)")
                self.lastLanguages.append(classification.identifier)
            }
      }
      
      func request(_ request: SNRequest, didFailWithError error: Error) {
          print("The the analysis failed: \(error.localizedDescription)")
      }
      
      func requestDidComplete(_ request: SNRequest) {
          print("The request completed successfully!")
      }
}
