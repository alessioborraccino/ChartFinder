//
//  chartfinderTests.swift
//  chartfinderTests
//
//  Created by Alessio Borraccino on 13/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import XCTest
@testable import chartfinder

class TestProfileManager : ProfileManager {

    static let testCountryKey = "test.selected.country.key"

    override internal var selectedCountryKey : String {
        return TestProfileManager.testCountryKey
    }
}

class ProfileManagerTests: XCTestCase {

    private var testProfileManager : TestProfileManager!

    override func setUp() {
        super.setUp()
        removeCountryFromUserDefaults()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLoadEmptySelectedUserCountry() {

        testProfileManager = TestProfileManager()
        let loadedCountry = testProfileManager.userSelectedCountry
        XCTAssertNil(loadedCountry)
    }

    func testLoadFullSelectedUserCountry() {

        addCountry1ToUserDefaults()

        testProfileManager = TestProfileManager()
        let loadedCountry = testProfileManager.userSelectedCountry

        XCTAssertEqual(loadedCountry?.name, "Alexia")
        XCTAssertEqual(loadedCountry?.code, "al")
    }

    func testSaveEmptySelectedUserCountry() {

        addCountry1ToUserDefaults()

        testProfileManager = TestProfileManager()
        testProfileManager.userSelectedCountry = nil

        let savedCountry = getCountryFromUserDefaults()
        XCTAssertNil(savedCountry)
    }

    func testSaveFullSelectedUserCountry() {

        addCountry1ToUserDefaults()

        testProfileManager = TestProfileManager()
        testProfileManager.userSelectedCountry = testCountry2()

        let savedCountry = getCountryFromUserDefaults()
        XCTAssertEqual(savedCountry?.name, "Bariland")
        XCTAssertEqual(savedCountry?.code, "bl")
    }

    private func getCountryFromUserDefaults() -> Country? {
        return Country.loadFromUserDefaultsWithKey(TestProfileManager.testCountryKey)
    }
    private func removeCountryFromUserDefaults() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(TestProfileManager.testCountryKey)
    }
    private func addCountry1ToUserDefaults() {
        Country.save(instance: testCountry1(), toUserDefaultsWithKey: TestProfileManager.testCountryKey)
    }
    private func testCountry1() -> Country {
        return Country(name: "Alexia", code: "al")
    }
    private func testCountry2() -> Country {
        return Country(name: "Bariland", code: "bl")
    }
}
