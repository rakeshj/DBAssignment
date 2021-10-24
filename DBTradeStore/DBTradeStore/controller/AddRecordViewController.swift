//
//  AddRecordViewController.swift
//  DBTradeStore
//
//  Created by rakeshj on 21/10/21.
//

import UIKit

class AddRecordViewController: UIViewController {
    
    
    var addRecordViewModel: AddRecordViewModelProtocol? 

    @IBOutlet weak var counterPartyIdTextField: UITextField!
    @IBOutlet weak var bookIdTextField: UITextField!
    @IBOutlet weak var maturityDateTextField: UITextField!
    @IBOutlet weak var versionTextField: UITextField!
    @IBOutlet weak var tradeIdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = DBTradeStoreScreenTitle.addRecord
        self.configureInputFields()
        initializeFields()
        }
           
    
    func initializeFields(){
        counterPartyIdTextField.text = DBTradeStoreStub.counterPartyId
        bookIdTextField.text = DBTradeStoreStub.bookId
        versionTextField.text = DBTradeStoreStub.version
        tradeIdTextField.text = DBTradeStoreStub.tradeId
        maturityDateTextField.text = Date().dateToString(date: Date())
    }
    
    func configureInputFields(){
        self.versionTextField.keyboardType = .numberPad
        self.maturityDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        }
       //2
       @objc func tapDone() {
           if let datePicker = self.maturityDateTextField.inputView as? UIDatePicker { // 2-1
               let dateformatter = DateFormatter() // 2-2
               dateformatter.dateStyle = .medium // 2-3
               self.maturityDateTextField.text = dateformatter.string(from: datePicker.date) //2-4
           }
           self.maturityDateTextField.resignFirstResponder() // 2-5
       }
    
    
   
    
    @IBAction func saveAction(_ sender: UIButton) {
        view.endEditing(true) // to remove the virtual keypad and proceed
        //write a logic to implement the save record
        let counterPartyId = counterPartyIdTextField.text ?? DBConstants.emptyString
        let version = versionTextField.text ?? DBConstants.emptyString
        let maturityDate = (maturityDateTextField.inputView as? UIDatePicker)?.date ?? Date()
        let tradeId = tradeIdTextField.text ?? DBConstants.emptyString
        let bookId = bookIdTextField.text  ?? DBConstants.emptyString
        
        let result = (addRecordViewModel?.saveTradeModel(counterPartyId: counterPartyId, version: version, maturityDate: maturityDate, tradeId: tradeId, bookId: bookId))!
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
