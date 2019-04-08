//
//  ViewController.swift
//  Checklists2
//
//  Created by Test on 02/04/2019.
//  Copyright © 2019 Peanch. All rights reserved.
//

import UIKit

class ChecklistsViewController: UITableViewController {

    var items: [ChecklistItem]
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [ChecklistItem]()
        super.init(coder: aDecoder)
        createAnItem(name: "Walk the dog", checked: true)
        createAnItem(name: "Make a tea", checked: false)
        createAnItem(name: "Hang out with", checked: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func createAnItem(name: String, checked: Bool) {
        let item = ChecklistItem()
        item.text = name
        item.checked = checked
        items.append(item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemTableViewController
            controller.delegate = self
        }
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    

    //MARK:- Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistCell", for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    // Remove the item from the data model,and delete the corresponding row from the tableview.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    //MARK:- Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
           let item = items[indexPath.row]
            item.toggleCheckmark()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
}

extension ChecklistsViewController: AddItemTableViewControllerDelegate {
    func addItemTableViewControllerDidCancel(_ controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func ddItemTableViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}

