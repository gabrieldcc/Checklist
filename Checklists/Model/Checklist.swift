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
    var iconName: String

    //MARK: - Init
    init(name: String, iconName: String = "No icon") {
        self.name = name
        self.iconName = iconName
        super.init()
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
