//
//  Task.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import Foundation

enum StatusTask: Codable{
  case ready
  case pending
  case late
}

struct Task: Codable{
  var id = Date().timeIntervalSince1970
  var title, description: String
  var deadLine : Double
  var status: StatusTask = .pending
  var sentNotification: Bool = false
}
