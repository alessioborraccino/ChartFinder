//
//  ChartResultsTableViewManager.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import RxSwift

class ChartResultsTableViewModel : NSObject, UITableViewDataSource {

    // MARK: Properties

    private var tracks = [Track]()

    // MARK: Initializers

    init(tracks: [Track]) {
        self.tracks = tracks
        super.init()
    }

    // MARK: TableView Methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let trackCell = tableView.dequeueReusableCellWithIdentifier(TrackCell.reuseIdentifier) {
            return trackCell
        } else {
            return TrackCell(style: .Default, reuseIdentifier: TrackCell.reuseIdentifier)
        }
    }

    func configureCell(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let trackCell = cell as! TrackCell
        trackCell.configure(track: tracks[indexPath.row], position: indexPath.row + 1)
    }
    func heightForRowAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return TrackCell.cellHeight
    }
    func trackAtRow(row: Int) -> Track {
        return self.tracks[row]
    }
}
