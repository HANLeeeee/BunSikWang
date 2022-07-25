//
//  ReultViewController.swift
//  Game_BunSikWang
//
//  Created by 하늘이 on 2022/07/24.
//

import UIKit

class ViewControllerReult: UIViewController {
    
    var resultScore: [Int] = []
    var resultScore2: [Int] = []

    @IBOutlet var labelResultScore: [UILabel]!
    @IBOutlet var labelResultScore2: [UILabel]!
    @IBOutlet var labelCalc: [UILabel]!
    @IBOutlet weak var labelToTalPlus: UILabel!
    @IBOutlet weak var labelTotalMinus: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    
    @IBOutlet weak var imageViewPM: UIImageView!
    @IBOutlet weak var labelPM: UILabel!
    
    @IBOutlet weak var tableViewRanking: UITableView!
    
    @IBOutlet var viewBG: [UIView]!
    
    
    @IBAction func btnReplayAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIResult()
        
        tableViewCellLoad()
    }
    
    func initUIResult() {
        
        viewBG.forEach {
            $0.layer.masksToBounds = false
            $0.layer.cornerRadius = 10
        }
        
        for num in 0..<labelResultScore.count {
            labelResultScore[num].text = "x\(numberFormatter(number: resultScore[num]))="
            labelCalc[num].text = numberFormatter(number: resultScore[num]*2000)
        }
        for num in 0..<labelResultScore2.count {
            labelResultScore2[num].text = numberFormatter(number: resultScore2[num])
        }
        
        labelToTalPlus.text = "+ \(numberFormatter(number: resultScore2.first!))"
        labelTotalMinus.text = "- \(numberFormatter(number: resultScore.last!*2000))"
        
        let totalCost = resultScore2.first!-(resultScore.last!*2000)
        if totalCost < 0 {
            //적자
            imageViewPM.image = UIImage(named: "icon_resultMinus")
            labelPM.text = "오늘은 적자ㅜ\n다음 영업은?"
            labelTotal.text = "- \(numberFormatter(number: abs(totalCost)))"
            labelTotal.textColor = .red
            
        } else {
            //흑자
            imageViewPM.image = UIImage(named: "icon_resultPlus")
            labelPM.text = "오늘은 흑자!\n다음 영업은?"
            labelTotal.text = "+ \(numberFormatter(number: totalCost))"
        }
    }
    
    func tableViewCellLoad() {
        let rankingTableViewCell = UINib(nibName: "RankingTableViewCell", bundle: nil)
        self.tableViewRanking.register(rankingTableViewCell, forCellReuseIdentifier: "RankingTableViewCell")
        
        tableViewRanking.rowHeight = 47
        
        self.tableViewRanking.dataSource = self
    }
}

extension ViewControllerReult: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewRanking.dequeueReusableCell(withIdentifier: "RankingTableViewCell", for: indexPath) as! RankingTableViewCell
        
        cell.labelRank.text = "\(userData[indexPath.row].rank)위"
        cell.labelRankUserID.text = userData[indexPath.row].userID
        cell.labelRankCost.text = "\(numberFormatter(number: userData[indexPath.row].rankCost))원"
        
        cell.selectionStyle = .none

        return cell
    }
    
    
}
