//
//  WebServicesTest.swift
//  test app tests
//
//  Created by Leonardo Flores Lopez on 13/12/20.
//

import XCTest
@testable import test_app


class WebServicesTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    

    func testGetTVShows() throws {
        let query = "girls"
        TVShow.getTVShows(query: query, completion: { (shows) in
            XCTAssertTrue(shows != nil)
            for show in shows! {
                XCTAssertTrue(show.name.contains(query))
            }
        })
    
    }
    
    func testGetShow() throws {
        let showId:Int64 = 130
        Show.getShow(showId: showId) { (show) in
            XCTAssertTrue(show != nil)
            XCTAssertTrue(show!.id == showId)
        }
    }
}
