//
//  UserDefaultsHelpers.swift
//  DreamTracker
//
//  Created by Iwan Hartono on 22/11/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation

extension UserDefaults {
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: "isLoggedIn")
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: "isLoggedIn")
    }
}
