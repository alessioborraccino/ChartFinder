//
//  LocalDataManager.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 14/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import Foundation

class LocalDataManager {

    static func availableCountries() -> [Country] {
        return [
            Country(name: "Australia", code: "au"),
            Country(name: "Canada", code: "ca"),
            Country(name: "Italy", code: "it"),
            Country(name: "France", code: "fr"),
            Country(name: "Germany", code: "de"),
            Country(name: "Greece", code: "gr"),
            Country(name: "Spain", code: "es"),
            Country(name: "Portugal", code: "pt"),
            Country(name: "Netherlands", code: "nl"),
            Country(name: "UK", code: "gb"),
            Country(name: "USA", code: "us")
        ]
    }
}