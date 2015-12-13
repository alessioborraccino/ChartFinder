//
//  UserDefaultsCompatible.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 20/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import Foundation

protocol UserDefaultsCompatible {
    
    init(dictionary: [String : AnyObject])
    func mapToDictionary() -> [String : AnyObject]
    
    static func save<T:UserDefaultsCompatible>(instance instance: T?, toUserDefaultsWithKey key: String)
    static func loadFromUserDefaultsWithKey<T:UserDefaultsCompatible>(key: String) -> T?
}

extension UserDefaultsCompatible {
    static func save<T:UserDefaultsCompatible>(instance instance: T?, toUserDefaultsWithKey key: String) {
        guard let instanceToSave = instance else {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
            return
        }
        let dictionary = instanceToSave.mapToDictionary()
        NSUserDefaults.standardUserDefaults().setObject(dictionary, forKey: key)
    }
    
    static func loadFromUserDefaultsWithKey<T:UserDefaultsCompatible>(key: String) -> T? {
        guard let dictionaryObject = NSUserDefaults.standardUserDefaults().objectForKey(key) else {
            return nil
        }
        guard let dictionary = dictionaryObject as? [String : AnyObject] else {
            return nil
        }
        return T(dictionary: dictionary)
    }
}