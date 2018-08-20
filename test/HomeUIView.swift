//
//  HomeUIView.swift
//  test
//
//  Created by 叶远辰 on 2018/8/20.
//  Copyright © 2018年 叶远辰. All rights reserved.
//

import UIKit

class HomeUIView: UIView {
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(click)))
//    }

    @IBAction func btnClick(_ sender: Any) {
        let rect = CGRect(x: 0, y: 80, width: bounds.width, height: 44)
        let sv = scrollView(frame: rect, count: 10, labelOfIndex: { index -> UILabel in
            let label = UILabel()
            label.text = "Hello \(index)"
            label.font = UIFont.systemFont(ofSize: 18)
            label.sizeToFit()
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        })
        addSubview(sv)
    }
    
//    @objc func click() {
//
//    }
    
    func scrollView(frame: CGRect, count: Int, labelOfIndex: (_ index: Int) -> UILabel) -> UIScrollView {
        let sv = UIScrollView(frame: frame)
        sv.backgroundColor = UIColor.lightGray
        var x: CGFloat = 0
        for i in 0..<count {
            let label = labelOfIndex(i)
            label.frame = CGRect(x: x, y: 0, width: label.bounds.width, height: frame.height)
            sv.addSubview(label)
            x += label.bounds.width
        }
        sv.contentSize = CGSize(width: x + 8.0, height: frame.height)
        return sv
    }

}
