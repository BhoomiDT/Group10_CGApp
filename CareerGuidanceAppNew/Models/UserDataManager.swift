//
//  UserDataManager.swift
//  CareerGuidanceAppNew
//
//  Created by SDC-USER on 15/12/25.
//

import Foundation

class UserDataManager {
    
    // We'll use a static property to hold the data, simulating a persistent storage.
    // Key: Username or Email (for quick lookup). We'll use Email as the primary key.
    private static var registeredUsers: [String: User] = [:]
    
    // Optional: Preload a test user for quick sign-in checks
    static func preloadTestData() {
        let testUser = User(
            username: "JaneDoe",
            email: "janedoe@example.com",
            password: "password123",
            confirmPassword: "Jane Doe"
        )
        // Use email as the key for lookup
        registeredUsers[testUser.email] = testUser
    }
    
    // MARK: - Sign Up Logic: Adding a New User
    
    static func registerUser(newUser: User) -> Bool {
        // Check if a user with this email already exists
        if registeredUsers.keys.contains(newUser.email) {
            return false // Registration failed: Email already in use
        }
        
        // Add the new user using email as the unique key
        registeredUsers[newUser.email] = newUser
        print("User registered: \(newUser.email)")
        return true // Registration successful
    }
    
    // MARK: - Sign In Logic: Checking Credentials
    
    static func signIn(email: String, passwordAttempt: String) -> User? {
        
        // 1. Look up the user by the provided email
        guard let storedUser = registeredUsers[email] else {
            return nil // Sign-in failed: User (email) not found
        }
        
        // 2. Check if the provided password matches the stored password
        if storedUser.password == passwordAttempt {
            return storedUser // Sign-in successful
        } else {
            return nil // Sign-in failed: Incorrect password
        }
    }
}
