//
//  Double.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import Foundation

extension Double{
  func getDateString()->String{
    let date = NSDate(timeIntervalSince1970: self)
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
  }
  
  func getDate()->Date{
    let date = NSDate(timeIntervalSince1970: self) as Date
    return date
  }
}
