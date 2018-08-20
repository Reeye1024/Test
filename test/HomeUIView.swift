//
//  HomeUIView.swift
//  test
//
//  Created by 叶远辰 on 2018/8/20.
//  Copyright © 2018年 叶远辰. All rights reserved.
//

import UIKit
import Alamofire

class HomeUIView: UIView {
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(click)))
//    }
    @IBOutlet weak var imgView: UIImageView!
    
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
    
    @IBAction func btnClick2(_ sender: Any) {
        print("==1===\(Thread.current)")
//        let utilityQueue = DispatchQueue.global(qos: .userInteractive)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request("http://60.174.203.118:8018/tender/", method: .post).responseJSON { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
            print("==2===\(Thread.current)")
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.download("https://s1.ax1x.com/2018/08/21/P4EwTS.jpg").downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }.responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            if let data = response.result.value {
                debugPrint("下载图片~~")
                let image = UIImage(data: data)
                self.imgView.image = image
            }
        }
    }
    
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
