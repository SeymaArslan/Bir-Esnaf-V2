//
//  FCollectionReference.swift
//  Bir Esnaf V2
//
//  Created by Seyma Arslan on 24.05.2024.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Recent
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
