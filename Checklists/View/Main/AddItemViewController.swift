//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 26/08/22.
//


import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
    func addItemAction(text: String)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: - Vars
    weak var delegate: AddItemViewControllerDelegate?
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        textField.delegate = self
        doneBarButton.isEnabled = false
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
        guard let textField = textField.text else { return }
        delegate?.addItemAction(text: textField)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
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

}


