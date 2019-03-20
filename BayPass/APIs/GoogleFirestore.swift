//
//  GoogleFirestore.swift
//  BayPass
//
//  Created by Hua Tong on 3/18/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Alamofire
import Foundation
import Firebase
import FirebaseFirestore

class GoogleFirestore{
    private init() {}
    
    static let shared = GoogleFirestore()
    
    func configure() {
        FirebaseApp.configure()
    }
    
    private func reference(to collectionReference: String) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference)
    }
    
    func create() {}
    
    func read() {
        
        //read data in all agencies
        reference(to: "Agencies").addSnapshotListener{ (snapshot, _) in
            guard let snapshot = snapshot else {return}
            for document in snapshot.documents {
                print(document.documentID)
                print(document.data())
            }
        }
    }
    
    func update() {}
    
    func delete() {}
}
