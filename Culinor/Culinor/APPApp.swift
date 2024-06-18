//
//  APPApp.swift
//  APP
//
//  Created by Mason Huang on 2024/5/31.
//

import SwiftUI

@main
struct APPApp: App {
    @StateObject var storageListVM = StorageListViewModel()
    var body: some Scene {
        WindowGroup {
//            ContentView()
            WelcomeView()
                .environmentObject(storageListVM)
        }
    }
}
