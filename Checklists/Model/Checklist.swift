//
//  File.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 02/09/22.
//

import Foundation
import UIKit

class Checklist: NSObject, Codable {
    
    //MARK: - Var
    var name: String
    var items = [ChecklistItem]()

    //MARK: - Init
    init(name: String) {
        self.name = name
    }
    
    //MARK: - Functions
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.isChecked {
            count += 1
        }
        return count
    }
}
