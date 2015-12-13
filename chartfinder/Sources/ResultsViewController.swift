//
//  ResultsViewController.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import RxSwift

class ResultsViewController: UIViewController, UITableViewDelegate {

    // MARK: Properties

    private let chartResultsTableViewModel : ChartResultsTableViewModel

    private let resultsTable : UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.separatorStyle = .None
        return tableView
    }()

    private var disposeBag = DisposeBag()

    // MARK: Initializers
    
    init(countryName: String, tracks: [Track]) {
        self.chartResultsTableViewModel = ChartResultsTableViewModel(tracks: tracks)
        super.init(nibName: nil, bundle: nil)
        self.title = "Top 10 \(countryName)"
        self.resultsTable.dataSource = chartResultsTableViewModel
        self.resultsTable.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View methods

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(resultsTable)
        setDefaultConstraints()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = self.resultsTable.indexPathForSelectedRow {
            self.resultsTable.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }

    private func setDefaultConstraints() {
        resultsTable.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }
    
    // MARK: TableView
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return chartResultsTableViewModel.heightForRowAtIndexPath(indexPath)
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        chartResultsTableViewModel.configureCell(cell, forRowAtIndexPath: indexPath)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let trackDetailViewController = TrackDetailViewController(track: chartResultsTableViewModel.trackAtRow(indexPath.row))
        self.navigationController?.pushViewController(trackDetailViewController, animated: true)
    }
}
