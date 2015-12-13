//
//  ProfileManager.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 14/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import Foundation

class ProfileManager {

    // MARK: Properties

    internal var selectedCountryKey : String {
        return "key.user.selected.country"
    }

    static let sharedInstance = ProfileManager()

    var userSelectedCountry : Country? {
        didSet {
            self.saveUserSelectedCountry(userSelectedCountry)
        }
    }

    // MARK: Initializers

    init() {
        self.userSelectedCountry = loadUserSelectedCountry()
    }

    // MARK: UserSelectedCountry
    
    internal func saveUserSelectedCountry(country: Country?) {
        Country.save(instance: country, toUserDefaultsWithKey:selectedCountryKey)
    }
    internal func loadUserSelectedCountry() -> Country? {
        return Country.loadFromUserDefaultsWithKey(selectedCountryKey)
    }
}
