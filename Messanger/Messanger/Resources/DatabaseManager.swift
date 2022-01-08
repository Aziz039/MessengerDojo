//
//  DatabaseManager.swift
//  Messanger
//
//  Created by Abdulaziz Alghamdi on 8/1/2022.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    public func test() {
        database.child("foo").setValue(["something": true])
    }
    
    
    
}

// MARK: - Account Manager
extension DatabaseManager {
    
    public func isUserExist(with email: String, completion: @escaping ((Bool) -> Void)) {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                print("false")
                print(snapshot.value)
                return
            }
            completion(true)
            print("true")
        })
    }
    
    
    /// Insert new user to database
    public func insertUser(with user: UserStruct) {
        database.child(user.safeEmail).setValue([
            "name": user.name
        ])
    }
}

struct UserStruct {
    let name: String
    let email: String
//    let profilePicURL: URL
    var safeEmail: String {
        let safeEmail = email.replacingOccurrences(of: ".", with: "-")
        return safeEmail
    }
}
