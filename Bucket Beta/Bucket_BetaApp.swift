//
//  Bucket_BetaApp.swift
//  Bucket Beta
//
//  Created by Alex Clark on 1/11/25.
//

import SwiftUI

@main
struct Bucket_BetaApp: App {
    @StateObject private var activityViewModel = ActivityViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(activityViewModel)
        }
    }
}
