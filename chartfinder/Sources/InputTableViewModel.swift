//
//  InputTableViewManager.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import RxSwift

class InputTableViewModel : NSObject, UITableViewDataSource, UIPickerViewDelegate {

    // MARK: Enums

    private enum MainSectionRow : Int {
        case Country
        case Picker
    }

    // MARK: Properties

    private var countryPickerViewModel : CountryPickerViewModel
    private var disposeBag = DisposeBag()
    
    // MARK: Initializers

    init(countryPickerViewModel : CountryPickerViewModel) {
        self.countryPickerViewModel = countryPickerViewModel
        super.init()
    }

    func selectedCountryCode() -> String? {
        return self.countryPickerViewModel.selectedCountry.value?.code
    }
    func selectedCountryName() -> String? {
        return self.countryPickerViewModel.selectedCountry.value?.name
    }
    
    // MARK: TableView

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch MainSectionRow(rawValue: indexPath.row)! {
        case .Country:
            if let inputCell = tableView.dequeueReusableCellWithIdentifier(InputCell.reuseIdentifier) {
                return inputCell
            } else {
                return InputCell(style: .Default, reuseIdentifier: InputCell.reuseIdentifier)
            }
        case .Picker:
            if let pickerCell = tableView.dequeueReusableCellWithIdentifier(PickerCell.reuseIdentifier) {
                return pickerCell
            } else {
                return PickerCell(style: .Default, reuseIdentifier: PickerCell.reuseIdentifier)
            }
        }
    }

    func heightForRowAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        switch MainSectionRow(rawValue: indexPath.row)! {
        case .Country:
            return InputCell.cellHeight
        case .Picker:
            return PickerCell.cellHeight
        }
    }

    func configureCell(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch MainSectionRow(rawValue: indexPath.row)! {
        case .Country:
            let inputCell = cell as! InputCell
            let countryNameObservable = countryPickerViewModel.selectedCountry.filter({ (country) -> Bool in
                return country != nil
            }).map { [unowned self] (country) -> String in
                return self.countryNameCellText(country!.name)
            }
            inputCell.configure("Country:", observableValue: countryNameObservable)
        case .Picker:
            let pickerCell = cell as! PickerCell
            pickerCell.setPickerViewDataSource(self.countryPickerViewModel)
            pickerCell.setPickerViewDelegate(self)
            if let selectedCountryIndex = countryPickerViewModel.indexOfSelectedCountry() {
                 pickerCell.setPickerSelected(row: selectedCountryIndex, component: 0)
            }
        }
    }
    
    // MARK: PickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryPickerViewModel.countryNameForRow(row)
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return countryPickerViewModel.heightForComponent(component)
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryPickerViewModel.selectCountryAtRow(row)
    }
    
    // MARK: Helpers
    
    private func countryNameCellText(countryName: String?) -> String {
        return countryName != nil ? countryName! : "No Country Selected"
    }
}

