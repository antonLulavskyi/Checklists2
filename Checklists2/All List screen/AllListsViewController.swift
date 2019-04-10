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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChecklist" {
            let controller = segue.destination as! ChecklistsViewController
            controller.checklist = sender as? Checklist
        } else if segue.identifier == "addChecklist" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = makeCell(for: tableView)
        
        let checklist = lists[indexPath.row]
        cell.textLabel?.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    func makeCell(for tableView: UITableView) -> UITableViewCell {
                
            return UITableViewCell(style: .default, reuseIdentifier: "cell")

    }
    // When you tap a row.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = lists[indexPath.row]
        performSegue(withIdentifier: "showChecklist", sender: checklist)
    }
    // Delete rows
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

}

extension AllListsViewController: ListDetailViewControllerDelegat {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        let newRowIndex = lists.count
        lists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        if let index = lists.index(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel?.text = checklist.name
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}
