//
//  CountryStruct.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 19/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import Foundation

struct Country : Equatable {
    let name: String
    let code: String
    
    init(name: String, code: String) {
        self.name = name
        self.code = code
    }
}

func ==(lhs: Country, rhs: Country) -> Bool {
    return lhs.name == rhs.name && lhs.code == rhs.code
}

extension Country : UserDefaultsCompatible {
    
    func mapToDictionary() -> [String : AnyObject] {
        return ["name" : self.name, "code" : self.code]
    }
    
    init(dictionary: [String : AnyObject]) {
        self.name = dictionary["name"] as! String
        self.code = dictionary["code"] as! String
    }
}