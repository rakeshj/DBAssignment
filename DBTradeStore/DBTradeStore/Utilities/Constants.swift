//
//  Constants.swift
//  DBTradeStore
//
//  Created by rakeshj on 24/10/21.
//

import Foundation


enum TradeModelValidationResult{
    case emptyField
    case invalidFormat
    case invalidMaturityDate
    case savedSuccess
    case goodToAdd
    case replace
    case lowerVersionError
    case resetTable
    case failToResetTable
    case unknownError
    
}


struct DBConstants {
     static let entityName = "DBTradeModel"
    static let emptyString = ""
    static let appname = "DB Store"
    static let ok = "Ok"
 }


struct DBMessage{
    static let failToReceiveData = "Fail to retrieve the data"
    static let failtoDelete = "Delete fails.."
    static let failtoDeleteAll = "Fail to delete all"
    static let failtoReplaceTheItem = "fail to replace the item"
    static let failtoFetchTradeItems = "Fetching traid items fails"
    static let failToSave = "saving failed"
    
    static let uknownError = "Unknown error! Please send details to jaiswal.rakesh@gmail.com to fix the issue."
    static let emptyFieldError = "All fields are mandatory to fill. please fill in all required fields."
    static let goodToSave = "Record has been saved successfully!"
    static let invalidFormatError = "Please enter the valid format."
    static let lowerVersionError = "Lower version error! Pleae enter the greater version number."
    static let replaceMsg = "Records updated successfully."
    static let maturityDateError = "Maturity date should be lesser than today's date."
    static let recordSaveMsg = "Record has been saved successfully!"
    static let tableResetMsg = "Table has been reset successfully"
    static let failtoResetTable = "Fail to reset table"
}


struct DBTradeModelFeild{
    static let tradeId = "tradeId" //tradeId
    static let counterPartyId = "counterPartyId"
    static let createdDate = "createdDate"
    static let maturityDate  = "maturityDate"
    static let  version = "version"
}


struct DBTradeStoreScreenTitle{
    static let home = "DB Store"
    static let addRecord = "Add Record"
    static let test = "DB Test"
}


struct DBTradeStoreSegue{
    static let addrecord = "showaddrecordscreen"
    static let test = "testSegue"
}

struct DBTradeStoreCellName{
    static let home = "tradecell"
}


struct DBTradeStoreStub{
    static let tradeId = "T1" //tradeId
    static let counterPartyId = "CP1"
    static let  version = "1"
    static let  versionInInt64: Int64 = 1
    static let bookId = "B1"
    
}
