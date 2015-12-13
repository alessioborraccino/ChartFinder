//
//  MusixmatchAPI.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON

class MusixmatchAPI {

    // MARK: Properties

    static let sharedAPI : MusixmatchAPI = MusixmatchAPI()

    private let apiKey = "9808f18882b26366d870493fa90f79b4"
    private let musixMatchBaseURL = "https://api.musixmatch.com/ws/1.1/"

    // MARK: API Methods
    
    func getTopTenForCountryCode(countryCode: String) -> Observable<[Track]> {

        let parameters = ["apikey" : apiKey,
                            "page" : "1",
                       "page_size" : "10",
                         "country" : countryCode]

        let url = requestURL(path: "chart.tracks.get", parameters: parameters)

        return NSURLSession.sharedSession().rx_swiftyJSON(url: url).map { json in
            return self.chartFromJSON(json)
        }
    }

    internal func chartFromJSON(json: JSON) -> [Track] {
        var tracks = [Track]()
        for (_,subJson) in json["message"]["body"]["track_list"] {
            tracks.append(Track(json: subJson["track"]))
        }
        return tracks
    }
    
    // MARK: Helpers
    
    private func requestURL(path path: String, parameters: [String : String]) -> NSURL {

        let parameterString = parameters.map { (parameter) -> String in
            return parameter.0 + "=" + parameter.1
        }.joinWithSeparator("&")

        let escapedParameters = URLEscape(parameterString)
        let urlContent = "\(musixMatchBaseURL)\(path)?\(escapedParameters)"
        return NSURL(string: urlContent)!
    }

    private func URLEscape(pathSegment: String) -> String {
        return pathSegment.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    }
}