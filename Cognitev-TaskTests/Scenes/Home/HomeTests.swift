//
//  HomeTests.swift
//  Cognitev-TaskTests
//
//  Created by Ahmed Ramy on 11/29/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import XCTest
@testable import Cognitev_Task
@testable import RxSwift

class HomeTests: BaseSceneTests {
    
    var viewModel: HomeViewModel!
    
    private lazy var testingStubs: ExploreResponse = {
        var feed = ExploreResponse()
        var group = Group()
        var groupItem = GroupItem()
        var venue = Venue()
        venue.name = "StarBucks"
        groupItem.venue = venue
        group.items = [groupItem, groupItem]
        feed.response?.groups = [group]
        return feed
    }()
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel(location: self.location, cache: self.cache, router: self.router, network: self.network)
        
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        Reachability.testingValue = nil
    }
    
    func testShowingToastWhenLocationFails() {
        // Given
        let error = NSError(domain: "Location Error", code: 0, userInfo: [:])
        location.error = error
        
        // When
        viewModel.fetchExploreFeed()
        
        // Then
        XCTAssert(router.actions.count == 3)
        XCTAssertEqual(router.actions[2], .toast("The operation couldn’t be completed. (Location Error error 0.)"))
    }
}
