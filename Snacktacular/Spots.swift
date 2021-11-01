//
//  Spots.swift
//  Snacktacular
//
//  Created by 최하림 on 10/31/21.
//

import Foundation
import Firebase

class Spots {
    var spotArray: [Spot] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("spots").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("😡 ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.spotArray = [] // clean out existing spotArray since new data will load
            // there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshot!.documents {
                // must make sure dictionary initializer is in the singular class
                let spot = Spot(dictionary: document.data())
                spot.documentID = document.documentID
                self.spotArray.append(spot)
            }
            completed()
        }
    }
}
