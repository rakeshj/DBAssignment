//
//  HomeViewModel.swift
//  DBTradeStore
//
//  Created by rakeshj on 21/10/21.
//

import Foundation

protocol HomeViewModelProtocol{
    func getTradeModels() -> [DBTradeModel]?
}

struct HomeViewModel: HomeViewModelProtocol{
    func getTradeModels() -> [DBTradeModel]? {
        return DBStoreManager.shared.getAllTradeModel()
    }
    
}
