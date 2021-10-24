//
//  DBAddRecordViewModelTest.swift
//  DBTradeStoreTests
//
//  Created by rakeshj on 24/10/21.
//

import XCTest
import CoreData
@testable import DBTradeStore

class DBAddRecordViewModelTest: XCTestCase {
    
    var addRecordViewModel: AddRecordViewModel!
    var storeManager: DBStoreManager!
    
    override func setUpWithError() throws {
        addRecordViewModel = AddRecordViewModel()
        storeManager = DBStoreManager.shared
        let _ = addRecordViewModel.resetTable()
        
    }
    
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testSaveTradeModel(){
        let today = Date().stripTime()
        let result = addRecordViewModel.saveTradeModel(counterPartyId: DBTradeStoreStub.counterPartyId, version: DBTradeStoreStub.version, maturityDate: today, tradeId: DBTradeStoreStub.tradeId, bookId: DBTradeStoreStub.bookId)
        XCTAssertTrue(result == .goodToAdd)
        
        if let item = storeManager.getModelsWithTradeId(tradeId: DBTradeStoreStub.tradeId)?.first{
            XCTAssertTrue(item.bookId == DBTradeStoreStub.bookId)
            XCTAssertTrue(item.counterPartyId  == DBTradeStoreStub.counterPartyId)
            XCTAssertTrue(item.version == DBTradeStoreStub.versionInInt64)
            XCTAssertTrue(item.maturityDate == today)
            XCTAssertTrue(item.tradeId == DBTradeStoreStub.tradeId)
            storeManager.delete(model: item)
        }
        
    }
    
    func testResetTable(){
        let result = addRecordViewModel.resetTable()
        XCTAssertTrue(result == .resetTable)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
