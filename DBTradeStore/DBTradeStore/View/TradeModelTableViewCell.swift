//
//  TradeModelTableViewCell.swift
//  DBTradeStore
//
//  Created by rakeshj on 22/10/21.
//

import UIKit

class TradeModelTableViewCell: UITableViewCell {

    @IBOutlet weak var counterPartyIdLabel: UILabel!
    @IBOutlet weak var expitedLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var bookIdLabel: UILabel!
    @IBOutlet weak var maturityDateLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var tradeIdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
