//
//  CountryPickerManager.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import UIKit
import RxSwift

class CountryPickerViewModel : NSObject, UIPickerViewDataSource {

    // MARK: Properties

    private let countries = LocalDataManager.availableCountries()
    var selectedCountry = Variable<Country?>(nil)

    // MARK: Initializers

    override init() {
        super.init()
        if let initialValue = ProfileManager.sharedInstance.userSelectedCountry {
            self.selectedCountry.value = initialValue
        } else {
            selectCountryAtRow(0)
        }
    }

    // MARK: PickerViewDataSource

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    func countryNameForRow(row: Int) -> String {
        return countries[row].name
    }
    
    // MARK: Delegate Logic
    
    func heightForComponent(component: Int) -> CGFloat {
        return UIUnit * 7
    }
    func selectCountryAtRow(row: Int) {
        self.selectedCountry.value = countries[row]
        ProfileManager.sharedInstance.userSelectedCountry = countries[row]
    }
    func indexOfSelectedCountry() -> Int? {
        guard let selectedCountryValue = selectedCountry.value else {
            return nil
        }
        return countries.indexOf(selectedCountryValue)
    }
}