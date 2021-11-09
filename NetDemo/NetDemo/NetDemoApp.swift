//
//  NetDemoApp.swift
//  NetDemo
//
//  Created by Jensen on 2021/11/5.
//

import SwiftUI

@main
struct NetDemoApp: App {
    private let netdemo = NetDemo()
    var body: some Scene {
        WindowGroup {
            ContentView(netdemo: netdemo)
        }
    }
}
