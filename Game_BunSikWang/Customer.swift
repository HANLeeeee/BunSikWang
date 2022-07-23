//
//  Customer.swift
//  Game_BunSikWang
//
//  Created by 하늘이 on 2022/07/20.
//

import Foundation
import UIKit


struct Customer {
    var tableImageView: UIImageView
    var exist: Bool
    var state: String
    var menu: String
    var menuImageView: UIImageView
    let tableTimer: UIProgressView
    var timerStart: Bool
}

var customerData: [Customer] = []

