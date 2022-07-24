//
//  ReultViewController.swift
//  Game_BunSikWang
//
//  Created by 하늘이 on 2022/07/24.
//

import UIKit

class ViewControllerReult: UIViewController {

    @IBOutlet weak var tableViewRanking: UITableView!
    
    @IBOutlet var viewBG: [UIView]!
    
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewRanking.dequeueReusableCell(withIdentifier: "RankingTableViewCell", for: indexPath) as! RankingTableViewCell
        
        cell.selectionStyle = .none

        return cell
    }
    
    
}
