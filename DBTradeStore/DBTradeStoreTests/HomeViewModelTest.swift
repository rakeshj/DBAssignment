//
//  HomeViewModelTest.swift
//  DBTradeStoreTests
//
//  Created by rakeshj on 24/10/21.
//

import XCTest
import CoreData
@testable import DBTradeStore


class HomeViewModelTest: XCTestCase {

    var homeViewModel: HomeViewModelProtocol!
    var addRecordViewModel: AddRecordViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        homeViewModel = HomeViewModel()
        addRecordViewModel =  AddRecordViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    
    func testGetTradeModels(){
        
        let today = Date().stripTime()
        let result = addRecordViewModel.saveTradeModel(counterPartyId: DBTradeStoreStub.counterPartyId, version: DBTradeStoreStub.version, maturityDate: today, tradeId: DBTradeStoreStub.tradeId, bookId: DBTradeStoreStub.bookId)
        XCTAssertTrue(result == .goodToAdd)
        
        let items = homeViewModel?.getTradeModels()
        XCTAssertTrue(items!.count > 0)
        let _ = addRecordViewModel.resetTable()
        
    }
    
    func testGetEmptyTradeModels(){
        
        let result = addRecordViewModel.resetTable()
        XCTAssertTrue(result == .resetTable)
        let items = homeViewModel?.getTradeModels()
        XCTAssertFalse(items!.count > 0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
