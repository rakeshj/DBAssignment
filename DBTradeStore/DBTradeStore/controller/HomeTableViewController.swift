//
//  HomeTableViewController.swift
//  DBTradeStore
//
//  Created by rakeshj on 20/10/21.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    @IBOutlet weak var testButton: UIBarButtonItem!
    
    let viewModel: HomeViewModelProtocol? = HomeViewModel()
    
    var tradeModels: [DBTradeModel]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = DBTradeStoreScreenTitle.home
        //        self.getTradeModels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getTradeModels()
        self.tableView.reloadData()
        
    }
    
    func getTradeModels(){
        self.tradeModels = viewModel?.getTradeModels()
        self.tableView.reloadData()
    }
    
//    @IBAction func testButtonAction(_ sender: UIBarButtonItem) {
//        // push the testing screen navigation
//        self.tradeModels = viewModel?.getTradeModels()
//    
//    
//    }
    
    @IBAction func addRecordAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: DBTradeStoreSegue.addrecord, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DBTradeStoreSegue.addrecord {
            if let nextViewController = segue.destination as? AddRecordViewController {
                nextViewController.addRecordViewModel  = AddRecordViewModel()
            }
        }else if segue.identifier == DBTradeStoreSegue.test {
            if let nextViewController = segue.destination as? DBTestViewController {
                nextViewController.addRecordViewModel  = AddRecordViewModel()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tradeModels?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DBTradeStoreCellName.home, for: indexPath) as! TradeModelTableViewCell
        
        let model = self.tradeModels![indexPath.row]
        cell.bookIdLabel.text = model.bookId
        
        cell.counterPartyIdLabel.text = model.counterPartyId
        cell.createDateLabel.text = Date().dateToString(date: model.createdDate!)
        cell.maturityDateLabel.text = Date().dateToString(date: model.maturityDate!)
        cell.tradeIdLabel.text = model.tradeId
        cell.versionLabel.text = String(model.version)
        if (model.maturityDate! > Date()){
            cell.expitedLabel.text = "N"
        }else{
            cell.expitedLabel.text = "F"
        }
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
}
