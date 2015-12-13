//
//  ViewController.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import RxSwift

class InputViewController: UIViewController, UITableViewDelegate, UIPickerViewDelegate  {

    // MARK: Properties

    private let inputTableViewModel = InputTableViewModel(countryPickerViewModel: CountryPickerViewModel())
    
    private let disposeBag = DisposeBag()

    private let inputTable : UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.separatorStyle = .None
        return tableView
    }()

    private let searchButton : SearchButton = {
        let button = SearchButton(title: "Search!")
        return button
    }()

    // MARK: View methods

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Chart finder"
        view.backgroundColor = UIColor.whiteColor()

        inputTable.dataSource = inputTableViewModel
        inputTable.delegate = self
        view.addSubview(inputTable)
        view.addSubview(searchButton)
        setDefaultConstraints()
        addSearchButtonAction()
        
        delayUIAction(showSearchButton, ofSeconds: 0.3)
    }

    private func setDefaultConstraints() {
        inputTable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp_top).offset(UIUnit * 2)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.bottom.equalTo(searchButton.snp_top)
        }

        searchButton.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(UIUnit * 13)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.height.equalTo(UIUnit * 13)
        }
    }

    private func showSearchButton() {
        searchButton.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom)
        }
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }

    private func delayUIAction(action: () -> (), ofSeconds seconds: Double) {
        timer(seconds, ConcurrentDispatchQueueScheduler(globalConcurrentQueuePriority: .Default))
            .observeOn(MainScheduler.sharedInstance)
            .subscribeNext { (_) -> Void in
                action()
            }.addDisposableTo(disposeBag)
    }
    // MARK: Behavior

    private func addSearchButtonAction() {
        searchButton.rx_tap.subscribeNext { [unowned self] () -> Void in
            guard let countryCode = self.inputTableViewModel.selectedCountryCode(),
                      countryName = self.inputTableViewModel.selectedCountryName() else {
                self.showError(title: "Sorry", body: "You need to select a country")
                return
            }
            self.searchChart(countryCode: countryCode, countryName: countryName)
        }.addDisposableTo(disposeBag)
    }

    private func searchChart(countryCode countryCode:String, countryName:String) {

        self.searchButton.setIsLoading()

        MusixmatchAPI.sharedAPI.getTopTenForCountryCode(countryCode).observeOn(MainScheduler.sharedInstance).subscribe { [unowned self] (event) -> Void in
            switch event {
                case .Next(let tracks):
                    let resultsViewController = ResultsViewController(countryName: countryName , tracks: tracks)
                    self.navigationController?.pushViewController(resultsViewController, animated: true)
                case .Error(_):
                    self.showError(title: "Sorry", body: "It is not possible at the moment to fetch the chart. Try again in a few moments.")
                case .Completed:
                    break
            }
            self.searchButton.setReady()
        }.addDisposableTo(disposeBag)
    }
    
    // MARK: TableviewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return inputTableViewModel.heightForRowAtIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        inputTableViewModel.configureCell(cell, forRowAtIndexPath: indexPath)
    }
}

