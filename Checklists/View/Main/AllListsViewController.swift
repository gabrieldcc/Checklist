//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 01/09/22.
//

import UIKit

class AllListsViewController: UITableViewController {
    
    //MARK: - Let
    let cellIdentifier = "ChecklistCell"
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Tableview

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = "List \(indexPath.row)"
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
}
