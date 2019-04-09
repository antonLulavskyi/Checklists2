//
//  ChecklistItem.swift
//  Checklists2
//
//  Created by Test on 03/04/2019.
//  Copyright © 2019 Peanch. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
  
    var text = ""
    var checked = false
    
    override init() {
        super.init()
    }
    
    func toggleCheckmark() {
        checked = !checked
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
}
