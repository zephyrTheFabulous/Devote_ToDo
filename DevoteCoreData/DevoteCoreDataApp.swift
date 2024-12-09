//
//  DevoteCoreDataApp.swift
//  DevoteCoreData
//
//  Created by Anthony on 10/11/24.
//

import SwiftUI

@main
struct DevoteCoreDataApp: App {
    let persistenceController = PersistenceController.shared

  @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
