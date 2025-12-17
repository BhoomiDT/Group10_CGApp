//
//  User.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 12/12/25.
//
// User.swift

import Foundation

struct User {
    let username: String
    let email: String
    let password: String
    let confirmPassword: String
}

class UserStore {
    static let shared = UserStore()   
    
    private init() {}
    
    private(set) var users: [User] = []
    
    func addUser(_ user: User) {
        users.append(user)
    }
}
