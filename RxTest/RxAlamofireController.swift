//
//  RxAlamofireController.swift
//  RxTest
//
//  Created by myxc on 2018/8/12.
//  Copyright © 2018 myxc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class RxAlamofireController: UIViewController {

    @IBOutlet weak var table: UITableView!

    let disposrBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!

        /* 普通方式
        request(.get, url).data().subscribe(onNext: { (data) in
            print(data)
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
            print("json :\(json!)")
        }).disposed(by: disposrBag) */
        
        // responseJSON()
//        request(.get, url).responseJSON().subscribe(onNext: { (data) in
//
//            let json = data.value as! [String : Any]
//
//            print("json :\(json)")
//
//        }).disposed(by: disposrBag)

       /* //tableView 绑定数据
        let data = requestJSON(.get, url).map{ reponse, data -> [[String: Any]] in
            if let json = data as? [String: Any],
                let channels = json["channels"] as? [[String: Any]] {
                return channels
            }else{
                return []
            }
        }
                data.bind(to: table.rx.items){ (tableview, row, elements) in
                    let cell = tableview.dequeueReusableCell(withIdentifier: "cell")
                    cell?.textLabel?.text = "\(row)：\(elements["name"]!)"
                    return cell!
                }.disposed(by: disposrBag) */
        
        /*
        //直接转对象
        requestJSON(.get,url).map{$1}.mapObject(type: Douban.self).subscribe(onNext:{ (douban: Douban) in
            if let channels = douban.channels {
                print("--- 共\(channels.count)个频道 ---")
                for channel in channels {
                    if let name = channel.name, let channelId = channel.channelId {
                        print("\(name) （id:\(channelId)）")
                    }
                }
                
            }
        
    }).disposed(by: disposrBag) */
        
        let data = requestJSON(.get, url).map{$1}.mapObject(type: Douban.self).map{$0.channels ?? []}
        
        data.bind(to: table.rx.items){ (tebleview, row, element) in
            let cell = tebleview.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = String.init(format: "%@--%@", element.name ?? "", element.channelId ?? "")
            cell?.detailTextLabel?.text = element.channelId
            return cell!
        }.disposed(by: disposrBag)

        
    }

}
