//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 26/08/22.
//


import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
  func addItemViewControllerDidCancel(_ controller: AddItemViewController)
  func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
  func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: ChecklistItem)
}

final class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: - Var
    weak var delegate: AddItemViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        textField.delegate = self
        doneBarButton.isEnabled = false
        setEditItemViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    //MARK: - IBAction
    @IBAction private func done(_ sender: UIBarButtonItem) {
        guard let text = textField.text else { return }
        let item = ChecklistItem(text: text)
        delegate?.addItemViewController(self, didFinishAdding: item)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func cancel(_ sender: UIBarButtonItem) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    //MARK: - Functions
    func setEditItemViewController() {
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    
    //MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text else { return false}
        guard let stringRange = Range(range, in: oldText) else { return false }
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        let textFieldHasText = !newText.isEmpty
        doneBarButton.isEnabled = textFieldHasText
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }


}


