//
//  User.swift
//  Game_BunSikWang
//
//  Created by 하늘이 on 2022/07/25.
//

import Foundation
import UIKit


struct User {
    let userID: String
    var rank: Int
    var rankCost: Int
}


var userData: [User] = [
    User(userID: "보라돌이", rank: 2, rankCost: 42000),
    User(userID: "텔레토비", rank: 1, rankCost: 58000),
    User(userID: "나나", rank: 4, rankCost: 12000),
    User(userID: "뚜비", rank: 3, rankCost: 34000),
    User(userID: "뽀", rank: 5, rankCost: 10000)
]
