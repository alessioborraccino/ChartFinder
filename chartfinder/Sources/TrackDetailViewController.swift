//
//  TrackDetailViewController.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 14/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import RxSwift

class TrackDetailViewController: UIViewController, UITableViewDelegate {

    // MARK: Properties

    private let trackDetailTableViewModel : TrackDetailTableViewModel

    private let detailsTable : UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.separatorStyle = .None
        return tableView
    }()

    // MARK: Initializers

    init(track: Track) {
        self.trackDetailTableViewModel = TrackDetailTableViewModel(track: track)
        super.init(nibName: nil, bundle: nil)
        self.title = "Track Detail"
        self.detailsTable.dataSource = trackDetailTableViewModel
        self.detailsTable.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailsTable)
        setDefaultConstraints()
    }

    private func setDefaultConstraints() {
        detailsTable.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }
    
    // MARK: TableView
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        trackDetailTableViewModel.configureCell(cell, atIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return trackDetailTableViewModel.heightForRowAtIndexPath(indexPath)
    }
}