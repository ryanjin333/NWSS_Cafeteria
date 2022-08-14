//
//  HomeControllerDatabase.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-08-13.
//

import Foundation
import FirebaseDatabase

struct HomeControllerDatabase {
    let database = Database.database().reference()
    
    
    func initializeFullMenuData() -> String {
        var text = ""
//        database.child("Menu").observeSingleEvent(of: .value, with: { snapshot in
//            guard let value = snapshot.value as? [String: Any] else { return }
//            text = value.description
//            
//        })
        database.child("Menu").observe(.value) {(snap: DataSnapshot) in
            text = snap.value as! String
        }
        return text
    }
    
    
    
}
