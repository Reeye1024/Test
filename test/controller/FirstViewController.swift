//
//  FirstViewController.swift
//  test
//
//  Created by 叶远辰 on 2018/8/24.
//  Copyright © 2018年 叶远辰. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "第一个"
        self.view.backgroundColor = UIColor.lightText
        
//        let rect = CGRect(x: 0, y: 40, width: self.view.bounds.size.width, height: 40)
//        let navBar = UINavigationBar(frame: rect)
//        self.view.addSubview(navBar)
//        let navItem = UINavigationItem(title: "item")
//        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .plain, target: self, action: #selector(nextPage))
//        navItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(retPrev))
//        navBar.pushItem(navItem, animated: true)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .plain, target: self, action: #selector(nextPage))
        
        let rect1 = CGRect(x: 50, y: 100, width: 100, height: 40)
        let btn1 = UIButton(frame: rect1)
        btn1.tag = 1
        btn1.setTitle("change icon", for: .normal)
        btn1.addTarget(self, action: #selector(changeIcon), for: .touchUpInside)
        self.view.addSubview(btn1)
        
        let rect2 = CGRect(x: 200, y: 100, width: 100, height: 40)
        let btn2 = UIButton(frame: rect2)
        btn2.tag = 2
        btn2.setTitle("default icon", for: .normal)
        btn2.addTarget(self, action: #selector(changeIcon), for: .touchUpInside)
        self.view.addSubview(btn2)
    }
    
    @objc func changeIcon(_ sender: UIButton) {
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                print("替换前图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                //当前显示的是原始图标
                if sender.tag == 1 {
                    UIApplication.shared.setAlternateIconName("Aicon", completionHandler: { (error: Error?) in
                        print("替换后图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                    })
                } else if sender.tag == 2 {
                    UIApplication.shared.setAlternateIconName(nil, completionHandler: { (error: Error?) in
                        print("替换后图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                    })
                }
            }
        }
    }
    
    @objc func nextPage() {
        let controller = SecondViewController()
//        self.present(controller, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func retPrev() {
        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.runtimeRemoveAlert()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.runtimeResetAlert()
    }
    
    //利用runtime指定方法实现
    func runtimeRemoveAlert() -> Void {
        if let presentM = class_getInstanceMethod(type(of: self), #selector(present(_:animated:completion:))),
            let presentSwizzlingM = class_getInstanceMethod(type(of: self), #selector(temporary_present(_:animated:completion:))){
            method_exchangeImplementations(presentM, presentSwizzlingM)
        }
    }
    //利用runtime恢复方法实现
    func runtimeResetAlert() -> Void {
        if let presentM = class_getInstanceMethod(type(of: self), #selector(present(_:animated:completion:))),
            let presentSwizzlingM = class_getInstanceMethod(type(of: self), #selector(temporary_present(_:animated:completion:))){
            method_exchangeImplementations(presentM, presentSwizzlingM)
        }
    }
    
    //在自己实现中特殊处理
    @objc dynamic func temporary_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil){
        if viewControllerToPresent.isKind(of: UIAlertController.self) {
            if let alertController = viewControllerToPresent as? UIAlertController{
                //通过判断title和message都为nil，得知是替换icon触发的提示。
                if alertController.title == nil && alertController.message == nil {
                    return;
                }
            }
        }
        self.temporary_present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
}
