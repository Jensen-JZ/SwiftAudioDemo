//
//  NetDemo.swift.swift
//  NetDemo
//
//  Created by Jensen on 2021/11/5.
//

import SwiftUI
import Alamofire

class NetDemo: ObservableObject {
    private static func createNet() -> Net {
        return Net(name: "测试")
    }
    
    @Published private var net = createNet()
    
    
    func decodeData(url: URL, completionHandler: @escaping ([String]) -> ()) {
        AF.request(url).responseData { response in
            var channels: [String] = []
            switch response.result {
            case let .success(data):
                print("API请求成功！")
                let decodedata = self.net.getJson(data: data)
//                print(decodedata.showapi_res_body.channelList)
                for channel in decodedata.showapi_res_body.channelList {
                    channels.append(channel.name)
                }
                completionHandler(channels)
            case .failure(_):
                print("API请求失败！")
            }
        }
    }
    

}

