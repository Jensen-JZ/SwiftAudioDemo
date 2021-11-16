//
//  SwiftDemo.swift
//  SwiftAudioDemo
//
//  Created by Jensen Jon on 2021/11/16.
//

import Foundation


struct Channels {
    var title: String
    var url: URL
    var image: String
    var voice: String
    
    init(title: String, url: URL, image: String) {
        self.title = title
        self.url = url
        self.image = image
        self.voice = self.image + "频道"
    }
}

class RadioChannels {
    var radioLists: [Channels] = []
    
    init() {
        radioLists.append(Channels(title: "央广 - 中国之声", url: URL(string: "http://ngcdn001.cnr.cn/live/zgzs/index.m3u8")!, image: "中国之声"))
//        radioLists.append(Channels(title: "安徽广电 - 交通广播", url: URL(string: "https://lhttp.qtfm.cn/live/1949/64k.mp3?app_id=web&ts=619268bc&sign=c234efd3041d14fcd823f7745c128062")!, image: "安徽交通广播"))
        radioLists.append(Channels(title: "央广 - 经济之声", url: URL(string: "http://ngcdn002.cnr.cn/live/jjzs/index.m3u8")!, image: "经济之声"))
//        radioLists.append(Channels(title: "安徽广电 - 新闻综合广播", url: URL(string: "https://lhttp.qtfm.cn/live/4919/64k.mp3?app_id=web&ts=61926953&sign=ed4e59a2775f9a97928cacec5dcc3829")!, image: "安徽新闻综合广播"))
        radioLists.append(Channels(title: "央广 - 音乐之声", url: URL(string: "http://ngcdn003.cnr.cn/live/yyzs/index.m3u8")!, image: "音乐之声"))
//        radioLists.append(Channels(title: "安徽广电 - 音乐广播", url: URL(string: "https://lhttp.qtfm.cn/live/1947/64k.mp3?app_id=web&ts=619269a8&sign=afaad279ca99b85567944f58fe6553ee")!, image: "安徽音乐广播"))
        radioLists.append(Channels(title: "央广 - 经典音乐之声", url: URL(string: "http://ngcdn004.cnr.cn/live/dszs/index.m3u8")!, image: "经典音乐之声"))
        radioLists.append(Channels(title: "央广 - 中华之声", url: URL(string: "http://ngcdn005.cnr.cn/live/zhzs/index.m3u8")!, image: "中华之声"))
        radioLists.append(Channels(title: "央广 - 神州之声", url: URL(string: "http://ngcdn006.cnr.cn/live/szzs/index.m3u8")!, image: "神州之声"))
        radioLists.append(Channels(title: "央广 - 民族之声", url: URL(string: "http://ngcdn009.cnr.cn/live/mzzs/index.m3u8")!, image: "民族之声"))
        radioLists.append(Channels(title: "央广 - 文艺之声", url: URL(string: "http://ngcdn010.cnr.cn/live/wyzs/index.m3u8")!, image: "文艺之声"))
        radioLists.append(Channels(title: "央广 - 大湾区之声", url: URL(string: "http://ngcdn007.cnr.cn/live/hxzs/index.m3u8")!, image: "大湾区之声"))
        radioLists.append(Channels(title: "央广 - 老年之声", url: URL(string: "http://ngcdn011.cnr.cn/live/lnzs/index.m3u8")!, image: "老年之声"))
        radioLists.append(Channels(title: "央广 - 香港之声", url: URL(string: "http://ngcdn008.cnr.cn/live/xgzs/index.m3u8")!, image: "香港之声"))
        radioLists.append(Channels(title: "央广 - 藏语之声", url: URL(string: "http://ngcdn012.cnr.cn/live/zygb/index.m3u8")!, image: "藏语之声"))
        radioLists.append(Channels(title: "央广 - 哈语之声", url: URL(string: "http://ngcdn025.cnr.cn/live/hygb/index.m3u8")!, image: "哈语之声"))
        radioLists.append(Channels(title: "央广 - 中国交通广播", url: URL(string: "http://ngcdn016.cnr.cn/live/gsgljtgb/index.m3u8")!, image: "中国交通广播"))
        radioLists.append(Channels(title: "央广 - 乡村之声", url: URL(string: "http://ngcdn017.cnr.cn/live/xczs/index.m3u8")!, image: "乡村之声"))
        radioLists.append(Channels(title: "央广 - 阅读广播", url: URL(string: "http://ngcdn014.cnr.cn/live/ylgb/index.m3u8")!, image: "阅读广播"))
        radioLists.append(Channels(title: "央广 - 维语之声", url: URL(string: "http://ngcdn013.cnr.cn/live/wygb/index.m3u8")!, image: "维语之声"))
        radioLists.append(Channels(title: "央广 - 南海之声", url: URL(string: "http://cnlive.cnr.cn/hls/nanhaizhisheng.m3u8")!, image: "南海之声"))
        radioLists.append(Channels(title: "央广 - CRI环球资讯", url: URL(string: "http://cnlive.cnr.cn/hls/huanqiuzixunguangbo.m3u8")!, image: "CRI环球资讯"))
    }
    
    func getRadio() -> [Channels] {
        return radioLists
    }
}
