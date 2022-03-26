//
//  LessonsAppApp.swift
//  LessonsApp
//
//  Created by Kevin Tierney on 3/25/22.
//

import SwiftUI

@main
struct LessonsAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
