//
//  MineViewController.swift
//  test
//
//  Created by 叶远辰 on 2018/8/20.
//  Copyright © 2018年 叶远辰. All rights reserved.
//

import UIKit

class MineViewController: UIView {
    
    @IBOutlet weak var lbl: UILabel!
    
    @IBAction func click(_ sender: Any) {
        let alert = UIAlertController(title: "提示", message: "alert一下", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .default) { (e) in
            self.lbl.text = "sssss"
        })
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { e in
            if let url = URL(string: "http://60.174.203.118:8018/tender/") {
                let request = URLRequest(url: url)
                let session = URLSession.shared
                let task = session.dataTask(with: request) { (data, res, error) in
                    if (error == nil) {
                        print("=================================")
                        if res is HTTPURLResponse {
                            print((res as! HTTPURLResponse).statusCode)
                        }
                        print("=================================")
                        print(data!)
                        print("=================================")
                        do {
                            let dict  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                            print(dict)
                            let d = dict as! [String: Any]
                            print(d["data"]!)
                        } catch {
                            print("error")
                        }
                    } else {
                        print(error as Any)
                    }
                }
                task.resume()
            }
        }))
        let controller = viewController()
        controller?.present(alert, animated: true, completion: nil)
    }
    
    func viewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        repeat {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        } while nextResponder != nil
        return nil
    }
    
}
