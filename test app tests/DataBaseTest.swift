//
//  DataBaseTest.swift
//  test app tests
//
//  Created by Leonardo Flores Lopez on 13/12/20.
//

import XCTest
@testable import test_app

class DataBaseTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testActionsTVShow() throws {
        
        let tvShow = TVShow()
        tvShow.id = 130
        tvShow.name = "Tests"
        tvShow.imgMediumUrl = "test_bad_url"
        saveAndDelete(tvShow: tvShow)
    
    }
    
    func saveAndDelete(tvShow: TVShow){
        TVShow.saveFavorite(tvShow: tvShow) { result in
            XCTAssertTrue(result)
            XCTAssertTrue(TVShow.isFavorite(tvShowId: tvShow.id))
        }
        
        TVShow.deleteFavorite(tvShowId: tvShow.id) { (result) in
            XCTAssertTrue(result)
            XCTAssertFalse(TVShow.isFavorite(tvShowId: tvShow.id))
        }
    }

}
