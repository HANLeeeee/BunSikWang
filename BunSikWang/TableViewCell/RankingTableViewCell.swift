//
//  RankingTableViewCell.swift
//  BunSikWang
//
//  Created by 하늘이 on 2022/07/24.
//

import UIKit

class RankingTableViewCell: UITableViewCell {

    @IBOutlet weak var labelRank: UILabel!
    @IBOutlet weak var labelRankUserID: UILabel!
    @IBOutlet weak var labelRankCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
