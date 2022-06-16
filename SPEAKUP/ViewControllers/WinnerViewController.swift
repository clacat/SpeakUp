//
//  WinnerViewController.swift
//  SPEAKFUCKINGAPP
//
//  Created by Alexey Antonov on 24.11.2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.
//

import UIKit

class WinnerViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "winnerCell", for: indexPath)
        
        let button = WinnerButton(title: players[indexPath.row].name, subtitle: players[indexPath.row].task!)
        button.addTarget(self, action: #selector(winnerButtonTouch(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        cell.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            button.topAnchor.constraint(equalTo: cell.topAnchor),
            button.widthAnchor.constraint(equalToConstant: 370),
            button.heightAnchor.constraint(equalToConstant: 175),
        ])
        
        return cell
    }
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.dataSource = self
    }
    
    @objc func winnerButtonTouch(_ sender: UIButton) {
        winners.append(String(sender.titleLabel!.text!.split(separator: "\n")[0]))
        sender.isEnabled = false
        
        doneButton.isEnabled = true
    }
}
