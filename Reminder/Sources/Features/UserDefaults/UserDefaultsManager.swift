//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 30/12/24.
//

import Foundation
import UIKit

class UserDefaultsManager {
    private static let userKey = "userKey"
    private static let userNameKey = "userName"
    private static let userPhotoKey = "userPhoto"
    private static let onboardingSeen = "onboardingSeen"

    static func saveUser(user: User) {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }

    static func saveUserName(name: String) {
        UserDefaults.standard.set(name, forKey: self.userNameKey)
        UserDefaults.standard.synchronize()
    }

    static func saveUserPhoto(photo: UIImage) {
        if let data = photo.jpegData(compressionQuality: 1) {
            UserDefaults.standard.set(data, forKey: self.userPhotoKey)
            UserDefaults.standard.synchronize()
        }
    }

    static func loadUser() -> User? {
        guard let userData = UserDefaults.standard.data(forKey: self.userKey) else {
            return nil
        }

        let decoder = JSONDecoder()
        if let user = try? decoder.decode(User.self, from: userData) {
            return user
        }

        return nil
    }

    static func loadUserPhoto() -> UIImage? {
        if let data = UserDefaults.standard.data(forKey: self.userPhotoKey) {
           return UIImage(data: data)
        }
       return UIImage(systemName: "person.fill")
    }

    static func loadUserName() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }

    static func removeUser() {
        UserDefaults.standard.removeObject(forKey: self.userKey)
        UserDefaults.standard.removeObject(forKey: self.userNameKey)
        UserDefaults.standard.removeObject(forKey: self.userPhotoKey)
        UserDefaults.standard.synchronize()
    }

    static func removeUsername() {
        UserDefaults.standard.removeObject(forKey: self.userNameKey)
        UserDefaults.standard.synchronize()
    }

    static func markOnboardingSeen() {
        UserDefaults.standard.set(true, forKey: onboardingSeen)
        UserDefaults.standard.synchronize()
    }

    static func hasSeenOnboarding() -> Bool {
        return UserDefaults.standard.bool(forKey: onboardingSeen)
    }
}
