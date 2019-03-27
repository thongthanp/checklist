//
//  ChecklistItem.swift
//  Checklists
//
//  Created by student on 20/2/2562 BE.
//  Copyright © 2562 Buu. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject,Codable{
    var text = ""
    var checked = false
    func toggleChecked(){
        checked = !checked
    }
}

