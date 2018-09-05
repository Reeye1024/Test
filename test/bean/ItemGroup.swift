//
//  ItemGroup.swift
//  test
//
//  Created by 叶远辰 on 2018/8/30.
//  Copyright © 2018年 叶远辰. All rights reserved.
//

import Foundation

public class ItemGroup {
    
    var section: String
    var items: [Item]
    
    init(section: String, items: [Item]) {
        self.section = section
        self.items = items
    }
    
}
