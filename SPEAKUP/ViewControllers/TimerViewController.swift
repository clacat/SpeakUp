//
//  TimerViewController.swift
//  SPEAKFUCKINGAPP
//
//  Created by Alexey Antonov on 24.11.2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var timePicker: UIPickerView!
    var times = [15, 20, 25]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.dataSource = self
        timePicker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let color = (row == timePicker.selectedRow( inComponent: component)) ? UIColor(red: 0.96, green: 0.76, blue: 0.05, alpha: 1.0) : UIColor.systemGray
        
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
          pickerView.reloadAllComponents() // hack to refresh all values while scrolling
        })

        return NSAttributedString(string: "\(self.times[row]) minutes", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 60.0)!])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        time = times[row]
    }
}
