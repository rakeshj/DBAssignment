//
//  DBTradeModel+CoreDataProperties.swift
//  DBTradeStore
//
//  Created by rakeshj on 23/10/21.
//
//

import Foundation
import CoreData


extension DBTradeModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBTradeModel> {
        return NSFetchRequest<DBTradeModel>(entityName: "DBTradeModel")
    }

    @NSManaged public var bookId: String?
    @NSManaged public var counterPartyId: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var maturityDate: Date?
    @NSManaged public var tradeId: String?
    @NSManaged public var version: Int64

}

extension DBTradeModel : Identifiable {

}
