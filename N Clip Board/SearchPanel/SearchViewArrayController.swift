//
//  SearchViewArrayController.swift
//  N Clip Board
//
//  Created by branson on 2019/11/9.
//  Copyright © 2019 branson. All rights reserved.
//

import Cocoa

class SearchViewArrayController: NSArrayController {
    override func arrange(_ objects: [Any]) -> [Any] {
        let objs = objects as NSArray
        
        return objs.sortedArray(using: sortDescriptors).filter { (rawItem) -> Bool in
            var content = "";
            guard let item = rawItem as? LabeledMO else { return false }
            
            guard let pbItem = item as? PBItemMO else {
                let snippet = item as! SnippetMO
                let content = String(data: snippet.content ?? .init(), encoding: .utf8)
                return filterPredicate?.evaluate(with: item, substitutionVariables: ["CONTENT": content!]) ?? false
            }
            
            if pbItem.contentType == Constants.stringTypeRawValue {
                content = String(data: pbItem.content!, encoding: .utf8) ?? ""
            }

            return filterPredicate?.evaluate(with: item, substitutionVariables: ["CONTENT": content]) ?? false
        }
    }
}
