//
//  DBStoreManager.swift
//  DBTradeStore
//
//  Created by rakeshj on 21/10/21.
//

import Foundation
import CoreData
import UIKit



struct DBStoreManager {
    
    static var shared = DBStoreManager()
    
    var items:[DBTradeModel]?
    
    let  viewContext = ((UIApplication.shared.delegate) as! DBTradeStore.AppDelegate).persistentContainer.viewContext
    
    private init(){
        
    }
    
    
    mutating func getAllTradeModel() -> [DBTradeModel]?{
        
        do{
            self.items = try viewContext.fetch(DBTradeModel.fetchRequest())
        }
        catch let error as NSError{
            print(DBMessage.failToReceiveData, error)
        }
        return self.items
    }
    
    func delete(model: DBTradeModel){
        viewContext.delete(model)
        do{
            try viewContext.save()
        }
        catch let error as NSError{
            print(DBMessage.failtoDelete, error)
        }
    }
    
    
    func deleteAllData(entity: String = DBConstants.entityName) -> Bool{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let arrUsrObj = try viewContext.fetch(fetchRequest)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                viewContext.delete(usrObj)
            }
            try viewContext.save() //don't forget
        } catch let error as NSError {
            print(DBMessage.failtoDeleteAll,error)
            return false
        }
        
        return true
    }
    
    func updateWithVersionId(counterPartyId: String, version: String, maturityDate: Date, tradeId: String, bookId: String){
        
        var tradeItems: [DBTradeModel]?
        do{
            let request = DBTradeModel.fetchRequest() as NSFetchRequest<DBTradeModel>
            let pred = NSPredicate(format: "version CONTAINS %@",  version)
            request.predicate = pred
            tradeItems = try viewContext.fetch(request)
            let itemToReplace = tradeItems?.first
            itemToReplace?.bookId = bookId
            itemToReplace?.counterPartyId = counterPartyId
            itemToReplace?.createdDate = Date()
            itemToReplace?.maturityDate = maturityDate
            itemToReplace?.version = Int64(version) ?? 0
            
            do{
                try viewContext.save()
            }
            catch let error as NSError{
                print(DBMessage.failtoReplaceTheItem, error)
            }
            
        }
        catch let error as NSError{
            print(DBMessage.failtoFetchTradeItems, error)
        }
        
    }
    
    
    
    func add(counterPartyId: String, version: String, maturityDate: Date, tradeId: String, bookId: String) -> DBTradeModel{
        let newTradeModel = DBTradeModel(context: viewContext)
        newTradeModel.bookId = bookId
        newTradeModel.counterPartyId = counterPartyId
        newTradeModel.createdDate = Date()
        newTradeModel.maturityDate = maturityDate
        newTradeModel.tradeId = tradeId
        newTradeModel.version = Int64(version) ?? 0
        do{
            try viewContext.save()
        }
        catch let error as NSError{
            print(DBMessage.failToSave, error)
        }
        return newTradeModel
    }
    
    func save(){
        do{
            try viewContext.save()
        }
        catch let error as NSError{
            print(DBMessage.failToSave, error)
        }
    }
    
    func getModelsWithTradeId(tradeId: String) -> [DBTradeModel]? {
        var tradeItems: [DBTradeModel]?
        do{
            let request = DBTradeModel.fetchRequest() as NSFetchRequest<DBTradeModel>
            let pred = NSPredicate(format: "tradeId CONTAINS %@", tradeId) //tradeId
            request.predicate = pred
            tradeItems = try viewContext.fetch(request)
        }
        catch let error as NSError{
            print(DBMessage.failtoFetchTradeItems, error)
        }
        return tradeItems
    }
    
    func getRecordLessthanVersion(tradeId: String, version: String) -> [DBTradeModel]?{
        
        var tradeItems: [DBTradeModel]?
        do{
            let request = DBTradeModel.fetchRequest() as NSFetchRequest<DBTradeModel>
            let pred = NSPredicate(format:"tradeId == %@  AND version > %@ ",   tradeId, version )
            request.predicate = pred
            let sort = NSSortDescriptor(key: DBTradeModelFeild.tradeId, ascending: true)
            request.sortDescriptors = [sort]
            request.fetchLimit = 1
            tradeItems = try viewContext.fetch(request)
        }
        catch let error as NSError{
            print(DBMessage.failtoFetchTradeItems, error)
        }
        return tradeItems
    }
}
