//
//  AddPlayerViewController.swift
//  SPEAKFUCKINGAPP
//
//  Created by Claudia Catapano on 20/11/2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import UIKit

class AddPlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var callbackAction: Action?
    var task = String()

    @IBOutlet weak var nicknameTexfield: UITextField!
    @IBOutlet weak var realPicker: UIPickerView!
    @IBOutlet weak var doneBotton: UIButton!
    
// Dismiss the view controller that was presented modally by the view controller
    @IBAction func done(_ sender: Any) {
           dismiss(animated: true, completion: nil)
    }
    
    var pickerData = ["Beginner", "Intermediate", "Advanced"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realPicker.dataSource = self
        realPicker.delegate = self
   
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func textFieldEditing(_ sender: UITextField) {
        if !sender.text!.isEmpty {
            self.doneBotton.setTitleColor(UIColor(red: 0.96, green: 0.76, blue: 0.05, alpha: 1.0), for: UIControl.State.normal)
            self.doneBotton.isEnabled = true
        } else {
            doneBotton.isEnabled = false
            doneBotton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //realPicker.reloadAllComponents()
        self.view.endEditing(true)
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let color = (row == realPicker.selectedRow( inComponent: component)) ? UIColor(red: 0.96, green: 0.76, blue: 0.05, alpha: 1.0) : UIColor.systemGray
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
          pickerView.reloadAllComponents() // hack to refresh all values while scrolling
        })

        return NSAttributedString(string: self.pickerData[row], attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func textFieldDidBeingEditing(_textField: UITextField) {
    }
    
    @IBAction func editinggDidEnd(_ sender: Any) {
        nicknameTexfield.resignFirstResponder()
   }
    
//to keep the data even when the view disappears
    override func viewDidDisappear(_ animated: Bool) {
        let x = Person(name: nicknameTexfield.text!, level: pickerData      [realPicker.selectedRow(inComponent: 0)], task: self.task)
        self.callbackAction?(x)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        }
    }
    
    
     













    
    

    
    

