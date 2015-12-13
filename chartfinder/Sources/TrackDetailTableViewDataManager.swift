//
//  TrackDetailTableViewManager.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 14/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import RxSwift

class TrackDetailTableViewModel : NSObject, UITableViewDataSource {

    // MARK: Properties

    private var track : Track

    // MARK: Initializers

    init(track: Track) {
        self.track = track
        super.init()
    }

    // MARK: TableView Methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let trackCoverCell = tableView.dequeueReusableCellWithIdentifier(TrackCoverCell.reuseIdentifier) {
            return trackCoverCell
        } else {
            return TrackCoverCell(style: .Default, reuseIdentifier: TrackCoverCell.reuseIdentifier)
        }
    }

    func heightForRowAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return TrackCoverCell.cellHeight
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let trackCoverCell = cell as! TrackCoverCell
        trackCoverCell.configure(track: track)
    }
}

