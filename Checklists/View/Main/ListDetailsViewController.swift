//
//  ListDetailsViewController.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 02/09/22.
//

import UIKit

protocol ListDetailsViewControllerDelegate: AnyObject {
    func listDetailsViewControllerDidCancel(_ controller: ListDetailsViewController)
    func itemDetailViewController(_ controller: ListDetailsViewController, didFinishAdding item: ChecklistItem)
    func listDetailsViewController(_ controller: ListDetailsViewController, didFinishEditing item: ChecklistItem)
}

class ListDetailsViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: - Var
    weak var delegate: ListDetailsViewController?
    var checklistToEdit: Checklist?
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
            textField.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    //MARK: - IBOutlets
    @IBOutlet var textField: UITextField!
    @IBOutlet var doneBarButton: UIBarButtonItem!
    
    // MARK: - IBActions
    @IBAction func cancel() {
      delegate?.listDetailViewControllerDidCancel(self)
    }
    @IBAction func done() {
      if let checklist = checklistToEdit {
        checklist.name = textField.text!
        delegate?.listDetailViewController(self, didFinishEditing: checklist)
      } else {
        let checklist = Checklist(name: textField.text!)
        delegate?.listDetailViewController(self, didFinishAdding: checklist)
      }
    }
    
    // MARK: - TextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text else { return false }
        guard let stringRange = Range(range, in: oldText) else { return false }
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        let textFieldHasText = !newText.isEmpty
        doneBarButton.isEnabled = textFieldHasText
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
    
    //MARK: - Tableview
    // tira a seleçao da celula (celula cinza)
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}
