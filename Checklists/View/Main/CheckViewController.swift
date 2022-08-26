//
//  ViewController.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 23/08/22.
//

import UIKit

final class CheckViewController: UITableViewController {
    
    //MARK: - Var
    private var items = [ChecklistItem]()
    
    //MARK: - Let
    private let row0item = ChecklistItem(text: "Walk the dog", isChecked: false)
    private let row1item = ChecklistItem(text: "Brush teeth", isChecked: false)
    private let row2item = ChecklistItem(text: "Learn iOS development", isChecked: false)
    private let row3item = ChecklistItem(text: "Soccer practice", isChecked: false)
    private let row4item = ChecklistItem(text: "Eat ice cream", isChecked: false)

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        appendItems()
    }
    
    //MARK: - Funcs
    private func appendItems() {
        items.append(row0item)
        items.append(row1item)
        items.append(row2item)
        items.append(row3item)
        items.append(row4item)
        
    }
    
    private func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
        let item = items[indexPath.row]
        var isChecked = false
        if indexPath.row == 0 {
            isChecked = row0item.isChecked
        } else if indexPath.row == 1 {
            isChecked = row1item.isChecked
        } else if indexPath.row == 2 {
            isChecked = row2item.isChecked
        } else if indexPath.row == 3 {
            isChecked = row3item.isChecked
        } else if indexPath.row == 4 {
            isChecked = row4item.isChecked
        }
        if item.isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    //MARK: - TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) {
            var isChecked = false
            if indexPath.row == 0 {
                item.isChecked.toggle()
                isChecked = row0item.isChecked
            } else if indexPath.row == 1 {
                item.isChecked.toggle()
                isChecked = row1item.isChecked
            } else if indexPath.row == 2 {
                item.isChecked.toggle()
                isChecked = row2item.isChecked
            } else if indexPath.row == 3 {
                item.isChecked.toggle()
                isChecked = row3item.isChecked
            } else if indexPath.row == 4 {
                item.isChecked.toggle()
                isChecked = row4item.isChecked
            }
            if isChecked {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            configureCheckmark(for: cell, at: indexPath)
        }
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row % 5 == 0 {
            label.text = item.text
        } else if indexPath.row % 5 == 1 {
            label.text = item.text
        } else if indexPath.row % 5 == 2 {
            label.text = item.text
        } else if indexPath.row % 5 == 3 {
            label.text = item.text
        } else if indexPath.row % 5 == 4 {
            label.text = item.text
        }
        configureCheckmark(for: cell, at: indexPath)
        return cell
    }

}

