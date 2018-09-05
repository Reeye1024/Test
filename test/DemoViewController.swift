//
//  DemoView.swift
//  test
//
//  Created by 叶远辰 on 2018/8/24.
//  Copyright © 2018年 叶远辰. All rights reserved.
//

import UIKit

class DemoViewController: UITableViewController {
    
    var config: [ItemGroup] = []
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return config.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return config[section].section
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 30))
        headerLabel.backgroundColor = .lightGray
        headerLabel.textColor = .darkGray
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.text = config[section].section
        headerLabel.font = UIFont.italicSystemFont(ofSize: 20)
        return headerLabel
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return config[section].items.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: id)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: id)
        }
        cell?.textLabel?.text = config[indexPath.section].items[indexPath.row].title
        cell?.detailTextLabel?.text = config[indexPath.section].items[indexPath.row].intro
        return cell!
    }

    override func viewDidLoad() {
        config.append(ItemGroup(section: "初识Xcode9.0的基本操作",
                                items: [
                                    Item(title: "在顶部状态栏显示风火轮", intro: "状态栏中转圈圈的图标"),
                                    Item(title: "读取iOS应用的配置信息", intro: "应用程序名称, 版本号, 唯一标识符, 配置信息"),
                                ]
        ))
        config.append(ItemGroup(section: "视图与视图控制器",
                                items: [
                                    Item(title: "UIView视图的基本使用", intro: ""),
                                    Item(title: "UIView视图的层次关系", intro: ""),
                                    Item(title: "UIView视图的基本操作", intro: ""),
                                    Item(title: "UIView视图添加边框效果", intro: ""),
                                    Item(title: "UIView视图添加圆角效果", intro: ""),
                                    Item(title: "UIView视图添加阴影效果", intro: ""),
                                ]
        ))
    }
    
}
