//
//  ChecklistItem.swift
//  Checklists2
//
//  Created by Test on 03/04/2019.
//  Copyright © 2019 Peanch. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleCheckmark() {
        checked = !checked
    }
}
