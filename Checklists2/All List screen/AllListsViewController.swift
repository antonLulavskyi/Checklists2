//
//  AllListsViewController.swift
//  Checklists2
//
//  Created by Test on 09/04/2019.
//  Copyright © 2019 Peanch. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
    
    var lists: [Checklist]
    
    required init?(coder aDecoder: NSCoder) {
        lists = [Checklist]()
        super.init(coder: aDecoder)
        
        createFakeData(name: "Birthdays")
        createFakeData(name: "Groceries")
        createFakeData(name: "Cool Apps")
    }
    
    func createFakeData(name: String) {
        let list = Checklist(name: name)
        lists.append(list)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = makeCell(for: tableView)
        cell.textLabel?.text = "List \(indexPath.row)"
        return cell
    }
    
    func makeCell(for tableView: UITableView) -> UITableViewCell {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")

    }
    // When you tap a row.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showChecklist", sender: nil)
    }

}
