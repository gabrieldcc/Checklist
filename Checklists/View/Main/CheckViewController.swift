//
//  ViewController.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 23/08/22.
//

import UIKit

final class CheckViewController: UITableViewController, AddItemViewControllerDelegate {
    
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
    
    //MARK: - Funcs
    func addItemAction(text: String) {
        let newRowIndex = items.count
        
        let item = ChecklistItem(text: text)
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
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
        
        if item.isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
        }
    }
    
    
    //MARK: - TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.isChecked.toggle()
            configureCheckmark(for: cell, with: item)
        }
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}

