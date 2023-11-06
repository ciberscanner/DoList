//
//  Date.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 6/11/23.
//

import Foundation

extension Date{
  func toString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    return dateFormatter.string(from: self)
  }
  
  func addMinutes( minutes: Int)->Date{
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .minute, value: minutes, to: self)
    return date!
  }
}
