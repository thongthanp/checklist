//
//  AllListsViewController.swift
//  Checklists
//
//  Created by student on 27/3/2562 BE.
//  Copyright © 2562 Buu. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
let cellIdentifier = "ChecklistCell"
var lists = [Checklist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.largeTitleDisplayMode = .never
        
        var list = Checklist()
        list.name = "Birthdays"
        lists.append(list)
        
        list = Checklist()
        list.name = "Groceries"
        lists.append(list)
        
        list = Checklist()
        list.name = "Cool App"
        lists.append(list)
        
        list = Checklist()
        list.name = "To Do"
        lists.append(list)
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel!.text = "\(lists[indexPath.row].name)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexpath:IndexPath) {
        performSegue(withIdentifier: "showChecklist", sender: nil)
    }



}
