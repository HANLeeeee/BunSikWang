//
//  NumberFormatter.swift
//  Game_BunSikWang
//
//  Created by 하늘이 on 2022/07/23.
//

import Foundation


//세자리단위로 나누어 콤마를 표시해줌 -> String으로 반환
public func numberFormatter(number: Int) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    
    return numberFormatter.string(from: NSNumber(value: number))!
}
