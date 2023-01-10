//
//  riyalatyApp.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 16/06/1444 AH.
//

import SwiftUI

@main
struct riyalatyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //testUIView()
          DaysView()
//                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
