//
//  AddRecordViewModel.swift
//  DBTradeStore
//
//  Created by rakeshj on 21/10/21.
//

import Foundation


struct AddRecordViewModel: AddRecordViewModelProtocol{
    

    
    func saveTradeModel(counterPartyId: String, version: String, maturityDate: Date, tradeId: String, bookId: String) -> TradeModelValidationResult {
        
        //check empty String
        if( counterPartyId.isEmpty || version.isEmpty || tradeId.isEmpty || bookId.isEmpty){
            return .emptyField
        }

        // validate the maturitydate
        if( isDateBeforeCurrentDate(date: maturityDate)){
            return .invalidMaturityDate
        }
        
        let validationResult =  validateTheVersion(version: version, tradeId: tradeId)
        
        if (validationResult == .replace){
            replaceModel(counterPartyId: counterPartyId, version: version, maturityDate: maturityDate, tradeId: tradeId, bookId: bookId)
        }else if (validationResult == .goodToAdd)
        {
            saveModel(counterPartyId: counterPartyId, version: version, maturityDate: maturityDate, tradeId: tradeId, bookId: bookId)
        }
        return validationResult
        
    }
    
    func replaceModel(counterPartyId: String, version: String, maturityDate: Date, tradeId: String, bookId: String){
        
        DBStoreManager.shared.updateWithVersionId(counterPartyId: counterPartyId, version: version, maturityDate: maturityDate, tradeId: tradeId, bookId: bookId)
    }
    
    private func saveModel(counterPartyId: String, version: String, maturityDate: Date, tradeId: String, bookId: String){
        let _ = DBStoreManager.shared.add(counterPartyId: counterPartyId, version: version, maturityDate: maturityDate, tradeId: tradeId, bookId: bookId)
    }
    
    private func isDateBeforeCurrentDate(date: Date) -> Bool {
        return date.stripTime() < Date().stripTime()
    }
    
    /*
     1.    During transmission if the lower version is being received by the store it will reject the trade and throw an exception. If the version is same it will override the existing record
     */
    private func validateTheVersion(version: String, tradeId: String) -> TradeModelValidationResult {
        var validationResult: TradeModelValidationResult = .goodToAdd
        let items:[DBTradeModel]? = DBStoreManager.shared.getModelsWithTradeId(tradeId: tradeId)
        if( items?.count == 0){
            return .goodToAdd
        }
        else if(items?.count == 1){
            if (items?.first?.version == Int64(version)){
                return .replace
            }else if((items?.first!.version)! > Int64(version)!){
                return .lowerVersionError
            }
        }
        else{
            items?.forEach{ (item) in
                if item.version > Int64(version)!{
                    print("Version: ", item.version)
                    validationResult = .lowerVersionError
                }else if item.version == Int64(version)!{
                    validationResult = .replace
                }
                
            }
                
        }
        return validationResult
    }
    
    func resetTable() -> TradeModelValidationResult{
        if DBStoreManager.shared.deleteAllData(){
            return .resetTable
        }else{
            return .failToResetTable
        }
    }
    
    
}


