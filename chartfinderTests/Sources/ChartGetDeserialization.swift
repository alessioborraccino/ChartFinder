//
//  ChartGetDeserialization.swift
//  chartfinder
//
//  Created by Alessio Borraccino on 20/12/15.
//  Copyright © 2015 Alessio Borraccino. All rights reserved.
//

import XCTest
import SwiftyJSON
import RxSwift

class MusixmatchTestAPI : MusixmatchAPI {

    override func getTopTenForCountryCode(countryCode: String) -> Observable<[Track]> {
        return create { (observer) -> Disposable in
            let json = self.parseChartFromString(self.loadChartGetStringFromFile())
            observer.onNext(self.chartFromJSON(json))
            observer.onCompleted()
            return NopDisposable.instance
        }
    }
    
    private func loadChartGetStringFromFile() -> String {
        if let pathTofile = NSBundle.mainBundle().pathForResource("chartGet", ofType: "json") {
            do {
                let jsonString = try NSString(contentsOfFile: pathTofile, encoding: NSUTF8StringEncoding)
                return jsonString as String
            } catch {
                print("Error parsing route file: \(error)")
            }
        } else {
            print("Error getting pathtoFile")
        }
        fatalError("Error parsing file")
    }
    
    private func parseChartFromString(string: String) -> JSON {
        return JSON.parse(string)
    }
}

class ChartGetDeserialization: XCTestCase {
    
    let musixMatchTestAPI = MusixmatchTestAPI()
    let disposeBag = DisposeBag()
    
    func testDeserializeChart() {
        musixMatchTestAPI.getTopTenForCountryCode("egal").subscribeNext { (chart) -> Void in
            XCTAssertEqual(chart[0].artist, "Adele")
            XCTAssertEqual(chart[0].title, "Hello")
            XCTAssertEqual(chart[0].duration, 296)
            XCTAssertEqual(chart[0].imageURL, "http://s.mxmcdn.net/images-storage/albums/1/0/7/6/5/0/32056701.jpg")
            XCTAssertEqual(chart[0].bigImageURL, "http://s.mxmcdn.net/images-storage/albums/1/0/7/6/5/0/32056701_500_500.jpg")
            XCTAssertEqual(chart[4].artist, "Marco Mengoni")
            XCTAssertEqual(chart[4].title, "Ti ho voluto bene veramente")
            XCTAssertEqual(chart[4].duration, 170)
            XCTAssertEqual(chart[4].imageURL, "http://s.mxmcdn.net/images-storage/albums/3/4/2/8/5/0/32058243.jpg")
            XCTAssertEqual(chart[4].bigImageURL, "http://s.mxmcdn.net/images-storage/albums/3/4/2/8/5/0/32058243_500_500.jpg")
        }.addDisposableTo(disposeBag)
    }
}
