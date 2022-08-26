//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 25/08/22.
//

import Foundation
import UIKit

class ChecklistItem {
    var text = ""
    var isChecked = false
    
    init(text: String, isChecked: Bool) {
        self.text = text
        self.isChecked = isChecked
    }
}
