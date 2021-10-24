//
//  DBStoreManagerTest.swift
//  DBTradeStoreTests
//
//  Created by rakeshj on 22/10/21.
//

import XCTest
import CoreData

@testable import DBTradeStore

class DBStoreManagerTest: XCTestCase {
    
    var storeManager: DBStoreManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storeManager = DBStoreManager.shared
        //prerequisite to clear all data to avoid any conflicts
        storeManager.deleteAllData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the clas
    }

    
    func testAddRecord(){
        let today = Date()
        let _ = storeManager.add(counterPartyId: "CP-1", version: "1", maturityDate: today, tradeId: "T01", bookId: "B1")
        if let item = storeManager.getModelsWithTradeId(tradeId: "T01")?.first{
            XCTAssertTrue(item.bookId == "B1")
            XCTAssertTrue(item.counterPartyId  == "CP-1")
            XCTAssertTrue(item.version == 1)
            XCTAssertTrue(item.maturityDate == today)
            XCTAssertTrue(item.tradeId == "T01")
//            storeManager.delete(model: item)
        }
    }
    
    func testUpdateRecord(){
        let _ = storeManager.add(counterPartyId: "CP-2", version: "1", maturityDate: Date(), tradeId: "T02", bookId: "B2")
        let date = Date()
        let _ = storeManager.updateWithVersionId(counterPartyId: "CP-12", version: "1", maturityDate: date, tradeId: "T02", bookId: "B12")
        let tradeModel = storeManager.getModelsWithTradeId(tradeId: "T02")?.first
        XCTAssertTrue(tradeModel?.counterPartyId == "CP-12")
        XCTAssertTrue(tradeModel?.bookId == "B12")
        XCTAssertTrue(tradeModel?.maturityDate == date)
        storeManager.delete(model: tradeModel!)
        
    }
    
    func testGetModelsWithTradeId(){
        let model = storeManager.add(counterPartyId: "CP-2", version: "1", maturityDate: Date(), tradeId: "T02", bookId: "B2")
        let tradeModel = storeManager.getModelsWithTradeId(tradeId: "T02")
        XCTAssertTrue(tradeModel!.count > 0)
        storeManager.delete(model: model)
        
    }
    
    func testDeleteRecored(){
        let model = storeManager.add(counterPartyId: "CP-2", version: "1", maturityDate: Date(), tradeId: "T02", bookId: "B2")
        let modelBeforeDelete = storeManager.getModelsWithTradeId(tradeId: "T02")
        XCTAssertTrue(modelBeforeDelete!.count > 0)
        storeManager.delete(model: model)
        
        let modelaftereDelete = storeManager.getModelsWithTradeId(tradeId: "T02")
        XCTAssertFalse(modelaftereDelete!.count > 0)
        
        
        
    }
    
    
    func testgetAllTradeModel(){
        
        let today = Date()
        let _ = storeManager.add(counterPartyId: "CP-2", version: "1", maturityDate: today, tradeId: "T02", bookId: "B2")
        let _ = storeManager.add(counterPartyId: "CP-1", version: "1", maturityDate: today, tradeId: "T01", bookId: "B1")
        let _ = storeManager.add(counterPartyId: "CP-3", version: "1", maturityDate: today, tradeId: "T03", bookId: "B3")
        
        let items = storeManager.getAllTradeModel()
        XCTAssertTrue(items?.count == 3)
        let _ = storeManager.deleteAllData()
        
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
