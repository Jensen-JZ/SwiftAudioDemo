//
//  Net.swift
//  NetDemo
//
//  Created by Jensen on 2021/11/5.
//

import Foundation
import SwiftUI
import Alamofire

struct Net {
    private var name: String
    
    init(name: String) {
        self.name = name
    }
    
    struct NewsChannels: Codable {
        var showapi_res_error: String?
        var showapi_res_id: String
        var showapi_res_code: Int
        var showapi_fee_num: Int
        var showapi_res_body: ResBody
    }
    
    struct ResBody: Codable {
        var totalNum: Int
        var channelList: [ChannelList]
        var ret_code: Int
    }
    
    struct ChannelList: Codable {
        var channelId: String
        var name: String
    }

    func getJson(data: Data) -> NewsChannels {
        try! JSONDecoder().decode(NewsChannels.self, from: data)
    }
    
//    func test(completionHandler: @escaping (NSDictionary?) -> ()) {
//        let url = "https://cdn.jsdelivr.net/gh/Jen-Jon/CDN_Bank/newschannels.json"
////        var jsonData: NewsChannels?
//        AF.request(url).responseJSON { response in
//            switch response.result {
//            case let .success(data):
//                print("API请求成功！")
//                completionHandler(data as? NSDictionary)
////                do{
////                    let jsonData = try JSONDecoder().decode(NewsChannels.self, from: data)
////                    print("数据解析成功！")
////                    print(jsonData.showapi_res_id)
////
////                    completionHandler(jsonData.showapi_res_id as? String)
////////                    return list
////                } catch let error {
////                    print("数据解析失败！")
////                    print(error)
////                }
//            case .failure(_):
//                print("API请求失败！")
////                completionHandler(error as Any)
//            }
//        }
//    }
    
    
//    func test() {
//        let url = "https://cdn.jsdelivr.net/gh/Jen-Jon/CDN_Bank/newschannels.json"
//        var jsonData: NewsChannels?
//        AF.request(url).responseData { response in
//            switch response.result {
//            case let .success(data):
//                print("API请求成功！")
//                do{
//                    jsonData = try JSONDecoder().decode(NewsChannels.self, from: data)
//                    print("数据解析成功！")
////                    return list
//                } catch let error {
//                    print("数据解析失败！")
//                    print(error)
//                }
//            case .failure(_):
//                print("API请求失败！")
//            }
//        }
//        print("jsonData是什么：")
//        print(jsonData)
//    }
}
