//
//  AddItemTableViewController.swift
//  Checklists2
//
//  Created by Test on 03/04/2019.
//  Copyright © 2019 Peanch. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func addItemTableViewControllerDidCancel(_ controller: AddItemTableViewController)
    func ddItemTableViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem)
}

class AddItemTableViewController: UITableViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    
    weak var delegate: AddItemTableViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        delegate?.addItemTableViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        let item = ChecklistItem()
        item.text = nameTextField.text!
        item.checked = false
        
        delegate?.ddItemTableViewController(self, didFinishAdding: item)
    }
    
    // This method allow selecting the row by passing an indexPath, or nil if you don't want to select
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

}

extension AddItemTableViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
       doneButton.isEnabled = (newText.length > 0)
        return true
    }
}
