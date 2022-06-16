//
//  RulesViewController.swift
//  SPEAKFUCKINGAPP
//
//  Created by Alexey Antonov on 25/11/2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        if navigationController!.isNavigationBarHidden {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
