//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 25/08/22.
//

import Foundation
import UIKit

class ChecklistItem: NSObject, Codable {
    
    //MARK: - Var
    var text = ""
    var isChecked = false
    
    //MARK: - Init
    init(text: String, isChecked: Bool = false) {
        self.text = text
        self.isChecked = isChecked
    }
}
