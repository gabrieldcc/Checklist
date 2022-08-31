//
//  ViewController.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 23/08/22.
//

import UIKit

final class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    //MARK: - Var
    private var items = [ChecklistItem]()
    var addItemVC = AddItemViewController()
    
    //MARK: - Let
    private let row0item = ChecklistItem(text: "Walk the dog")
    private let row1item = ChecklistItem(text: "Brush teeth")
    private let row2item = ChecklistItem(text: "Learn iOS development")
    private let row3item = ChecklistItem(text: "Soccer practice")
    private let row4item = ChecklistItem(text: "Eat ice cream")
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        appendItems()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Functions
    func addItemAction(text: String) {
        
    }
    
    private func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    private func appendItems() {
        items.append(row0item)
        items.append(row1item)
        items.append(row2item)
        items.append(row3item)
        items.append(row4item)
    }
    
    private func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel

        if item.isChecked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    
    //MARK: - AddItemViewControllerDelegate
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: ChecklistItem) {
        
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
            
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
            
            guard let indexPath = tableView.indexPath(for: sender as! UITableViewCell) else { return }
            controller.itemToEdit = items[indexPath.row]
        }
    }
    
    
    //MARK: - TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.isChecked.toggle()
            configureCheckmark(for: cell, with: item)
        }
        print(#function)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    // MARK: - Table View Delegates
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }


}

