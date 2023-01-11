//
//  CoreDataManeger.swift
//  riyalaty
//
//  Created by Ghada Amer Alshahrani on 18/06/1444 AH.
//

import Foundation
import CoreData

class CoreDataManeger {
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManeger = CoreDataManeger()
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "riyalaty")
        persistentContainer.loadPersistentStores { description , error in
            if let error = error {
                fatalError("Unable to initiize Core Data \(error)")
            }
            
        }
        
    }
    
    
}
