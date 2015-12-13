//
//  Track.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Track {

    let artist : String?
    let title : String?
    let imageURL : String?
    let bigImageURL : String?
    let duration : Int?

    init(json: JSON) {
        self.artist = json["artist_name"].string
        self.title = json["track_name"].string
        self.duration = json["track_length"].int
        self.imageURL = json["album_coverart_100x100"].string
        self.bigImageURL = json["album_coverart_500x500"].string
    }
}