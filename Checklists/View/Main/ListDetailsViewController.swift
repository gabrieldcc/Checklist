//
//  ListDetailsViewController.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 02/09/22.
//

import UIKit

protocol ListDetailViewControllerDelegate: AnyObject {
    func listDetailViewControllerDidCancel(_ controller: ListDetailsViewController)
    func itemDetailViewController(_ controller: ListDetailsViewController, didFinishAdding item: Checklist)
    func listDetailViewController(_ controller: ListDetailsViewController, didFinishEditing item: Checklist)
}

class ListDetailsViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: - Var
    weak var delegate: ListDetailViewControllerDelegate?
    var checklistToEdit: Checklist?
    var iconPickerVC: IconPickerViewController?
    var iconName = "Folder"
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
            textField.delegate = self
            iconName = checklist.iconName
        }
        iconImage.image = UIImage(named: iconName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    //MARK: - IBOutlets
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet var doneBarButton: UIBarButtonItem!
    
    // MARK: - IBActions
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    @IBAction func done() {
        if let checklist = checklistToEdit, let text = textField.text {
            checklist.name = text
            checklist.iconName = iconName
            delegate?.listDetailViewController(self, didFinishEditing: checklist)
            delegate?.listDetailViewController(self, didFinishEditing: checklist)
        } else {
            guard let text = textField.text else { return }
            let checklist = Checklist(name: text)
            checklist.iconName = iconName
            delegate?.itemDetailViewController(self, didFinishAdding: checklist)
        }
    }
    
    
    
    // MARK: - TextFieldDelegate
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
    
    //MARK: - Tableview
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.section == 1 ? indexPath : nil
    }
    
}

//MARK: - IconPickerViewController Delegate
extension ListDetailsViewController: IconPickerViewControllerDelegate {
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String) {
        self.iconName = iconName
        iconImage.image = UIImage(named: iconName)
        navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - Navigation
extension ListDetailsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickIcon" {
            let controller = segue.destination as! IconPickerViewController
            controller.delegate = self
        }
    }
    
}
