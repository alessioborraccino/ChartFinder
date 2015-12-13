//
//  Int+TimeString.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 14/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import Foundation

extension String {

    init(durationFormatWithSeconds seconds: Int) {
        let minutes = seconds / 60
        let seconds = seconds % 60
        self.init(format: "%i:%02d", minutes,seconds)
    }
}