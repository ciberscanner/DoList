//
//  HomeView.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import Foundation

protocol HomeView: NSObjectProtocol{
  func updateTable(items: [Task])
  func refreshTable()
}
