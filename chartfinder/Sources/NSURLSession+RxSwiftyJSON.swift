//
//  NSURLSession+RxSwiftyJSON.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 14/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

extension NSURLSession {

    func rx_swiftyJSON(url url: NSURL) -> Observable<JSON> {
        return NSURLSession.sharedSession().rx_data(NSURLRequest(URL: url)).map { jsonData in
            let json = JSON(data: jsonData)
            return json
        }
    }
}