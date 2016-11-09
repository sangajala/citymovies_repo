//
//  UserDefaultsStore.swift
//  CityMovies
//
//  Created by Deepthi Kaligi on 05/05/2016.
//  Copyright © 2016 BananaLabs. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {
    static let kUserNameKey = "username"
    static let kPasswordKey = "password"
    static let kSkipEvent = "skipEvent"
}

struct UserDefaultsStore  {
    
    static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    //MARK: -This must be used on login
    static func saveUserName (username_: String , password : String) -> Bool {
        userDefaults.setValue(username_, forKey: UserDefaultsKeys.kUserNameKey)
        
        //We will replace passowrd with accessToken once the login services are implemented
        userDefaults.setValue(password, forKey: UserDefaultsKeys.kPasswordKey)
        
        return  userDefaults.synchronize()
    }
    
    //MARK: -This must be used on logout
    static func deleteUserName (username_ : String , password : String) -> Bool {
        
        userDefaults.setValue("", forKey: UserDefaultsKeys.kUserNameKey)
        userDefaults.setValue("", forKey: UserDefaultsKeys.kPasswordKey)
        
        return  userDefaults.synchronize()
    }
}
