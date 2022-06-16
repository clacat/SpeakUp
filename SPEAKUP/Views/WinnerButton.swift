//
//  WinnerButton.swift
//  SPEAKFUCKINGAPP
//
//  Created by Alexey Antonov on 24/11/2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import UIKit

class WinnerButton: UIButton {

    required init(title: String, subtitle: String) {
        //super.init(frame: CGRect.zero)
        super.init(frame: CGRect(x: 0, y: 0, width: 370, height: 175))

        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineBreakMode = NSLineBreakMode.byWordWrapping

        let titleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font : UIFont(name: "Noteworthy-Bold", size: 24.0)!,
            NSAttributedString.Key.paragraphStyle : style
        ]
        let subtitleAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 20.0),
            NSAttributedString.Key.paragraphStyle : style
        ]

        let attributedString = NSMutableAttributedString(string: title, attributes: titleAttributes)
        attributedString.append(NSAttributedString(string: "\n"))
        attributedString.append(NSAttributedString(string: subtitle, attributes: subtitleAttributes))

        setAttributedTitle(attributedString, for: UIControl.State.normal)
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        setBackgroundImage(UIImage(named: "winnerstasks"), for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

}
