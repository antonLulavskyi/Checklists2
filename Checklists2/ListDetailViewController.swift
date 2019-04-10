//
//  ListDetailViewController.swift
//  Checklists2
//
//  Created by Test on 10/04/2019.
//  Copyright © 2019 Peanch. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegat: class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    weak var delegate: ListDetailViewControllerDelegat?
    
    var checklistToEdit: Checklist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextField.delegate = self
        
        if let checklist = checklistToEdit {
            title = " Edit Checklist"
            myTextField.text = checklist.name
            doneButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTextField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let checkist = checklistToEdit {
            checkist.name = myTextField.text!
            delegate?.listDetailViewController(self, didFinishEditing: checkist)
        } else {
            let checklist = Checklist(name: myTextField.text!)
            delegate?.listDetailViewController(self, didFinishAdding: checklist)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

}

extension ListDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = myTextField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
        doneButton.isEnabled = (newText.length > 0)
        return true
        
    }
}
