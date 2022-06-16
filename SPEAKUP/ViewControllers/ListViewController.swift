//  ListViewController.swift
//  SPEAKFUCKINGAPP
//  Created by Claudia Catapano on 20/11/2019.
//  Copyright © 2019 Claudia Catapano. All rights reserved.


import UIKit

//create a type Action that takes as parameter Person
typealias Action = (_ x: Person)->()

class ListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var doneTapped: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if navigationController!.isNavigationBarHidden {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    
//add objects to the array "players" and update the tableview in order that cells will be filled in the right way
   func modalAction() -> Action? {
        return { [unowned self] x in
            players.append(x)
            self.tableView.reloadData()
            if players.count > 1 {
                self.doneTapped.isEnabled = true
            }
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
// creating a cell of this type
//returns an existing cell of the specified type, if one is available, or it creates and returns a new cell using the class or storyboard you provided earlier
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
//tell the cell to fill it with the name of the player
        cell.textLabel?.text = players[indexPath.row].name
        return cell
    }
//enable user to delete a cell, updating the table view and also removing the data from the players array
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            players.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addplayer" {
        let vc = segue.destination as! AddPlayerViewController
        vc.callbackAction = modalAction()
     }
   }
    
    @IBAction func doneTapped(_ sender: Any) {
        doneTapped.isOpaque = true 
    }
}
