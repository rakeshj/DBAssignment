//
//  DBTestViewController.swift
//  DBTradeStore
//
//  Created by rakeshj on 21/10/21.
//

import UIKit

class DBTestViewController: UIViewController {
    
    let storeManager = DBStoreManager.shared
    var addRecordViewModel: AddRecordViewModelProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = DBTradeStoreScreenTitle.test
    }
    
    
    @IBAction func invalidFormatAction(_ sender: UIButton) {
        //        storeManager.getRecordLessthanVersion(tradeId: "T1", version: "1")
        let today = Date()
        let result = (addRecordViewModel?.saveTradeModel(counterPartyId: "", version: "", maturityDate: today, tradeId: "", bookId: "")) ?? .emptyField
        self.showError(errorType: result)
        
    }
    
    @IBAction func InvalideMaturityDateAction(_ sender: Any) {
        let today = Date()
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let result = (addRecordViewModel?.saveTradeModel(counterPartyId: "CP1", version: "1", maturityDate: modifiedDate, tradeId: "T1", bookId: "B1")) ?? .emptyField
        self.showError(errorType: result)
    }
    
    
    @IBAction func saveSuccessAction(_ sender: UIButton) {
        let today = Date()
        let result = (addRecordViewModel?.saveTradeModel(counterPartyId: "CP1", version: "1", maturityDate: today, tradeId: "T1", bookId: "B1")) ?? .emptyField
        self.showError(errorType: result)
    }
    
    
    
    @IBAction func lowerVersionErrorAction(_ sender: UIButton) {
        let today = Date()
        let _ = (addRecordViewModel?.saveTradeModel(counterPartyId: "CP8", version: "2", maturityDate: today, tradeId: "T8", bookId: "B8")) ?? .emptyField
        
        let result = (addRecordViewModel?.saveTradeModel(counterPartyId: "CP8", version: "1", maturityDate: today, tradeId: "T8", bookId: "B8")) ?? .emptyField
        self.showError(errorType: result)
    }
    
    @IBAction func purgeDBAction(_ sender: UIButton) {
        showError(errorType: (addRecordViewModel?.resetTable())!)
    }
    
    
    
    @IBAction func sameVersionUpdateAction(_ sender: UIButton) {
        let today = Date()
        let _ = (addRecordViewModel?.saveTradeModel(counterPartyId: "CP7", version: "2", maturityDate: today, tradeId: "T7", bookId: "B7")) ?? .emptyField
        let result = (addRecordViewModel?.saveTradeModel(counterPartyId: "CP9", version: "2", maturityDate: today, tradeId: "T9", bookId: "B9")) ?? .emptyField
        self.showError(errorType: result)
    }
    
    
    func showError(errorType: TradeModelValidationResult){
        var  message: String = DBMessage.uknownError
        switch errorType{
        case .emptyField:
            message = DBMessage.emptyFieldError
        case .goodToAdd:
            message = DBMessage.goodToSave
        case .invalidFormat:
            message = DBMessage.invalidFormatError
        case .lowerVersionError:
            message = DBMessage.lowerVersionError
        case .replace:
            message = DBMessage.replaceMsg
        case .unknownError:
            message = DBMessage.uknownError
        case .invalidMaturityDate:
            message = DBMessage.maturityDateError
        case .savedSuccess:
            message = DBMessage.recordSaveMsg
        case .resetTable:
            message = DBMessage.tableResetMsg
        case .failToResetTable:
            message = DBMessage.failtoResetTable
        }
        
        let alert = UIAlertController(title: DBConstants.appname, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: DBConstants.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
