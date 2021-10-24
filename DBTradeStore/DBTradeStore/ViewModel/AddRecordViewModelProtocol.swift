//
//  AddRecordViewModelProtocol.swift
//  DBTradeStore
//
//  Created by rakeshj on 24/10/21.
//

import Foundation

protocol AddRecordViewModelProtocol{
    func saveTradeModel(counterPartyId: String, version: String, maturityDate: Date, tradeId: String, bookId: String) -> TradeModelValidationResult
    func resetTable() -> TradeModelValidationResult
}
