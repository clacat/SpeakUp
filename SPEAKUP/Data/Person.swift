//
//  Person.swift
//  SPEAKFUCKINGAPP
//
//  Created by Claudia Catapano on 20/11/2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import Foundation


struct  Person {
    var name: String
    var level: String
    var task: String?
    
    init(name: String, level: String, task: String) {
        self.name = name
        self.level = level
        self.task = task
    }
}


var players = [Person]()
var time = 15
var globalTopic = ""
var winners = [String]()



