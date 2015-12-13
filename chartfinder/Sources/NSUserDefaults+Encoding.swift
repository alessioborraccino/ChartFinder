//
//  NSUserDefaults+Encoding.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 14/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import Foundation

extension NSUserDefaults {

    func ab_encode<T:AnyObject where T:NSSecureCoding>(object object:T?, key: String) {
        if let unwrappedObject = object {
            let objectData = NSKeyedArchiver.archivedDataWithRootObject(unwrappedObject)
            NSUserDefaults.standardUserDefaults().setObject(objectData, forKey: key)
        } else {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }
    }

    func ab_decodeObject(key key: String) -> AnyObject? {
        let data = NSUserDefaults.standardUserDefaults().objectForKey(key) as? NSData
        if let objectData = data, let object = NSKeyedUnarchiver.unarchiveObjectWithData(objectData) {
            return object
        }
        return nil
    }
}