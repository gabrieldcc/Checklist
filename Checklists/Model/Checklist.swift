//
//  File.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 02/09/22.
//

import Foundation
import UIKit

class Checklist: NSObject, Codable {
    var name: String
    var items = [ChecklistItem]()

    init(name: String) {
        self.name = name
    }
}
