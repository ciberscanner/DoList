//
//  TaskTableViewCell.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
  @IBOutlet weak var titleTask: UILabel!
  @IBOutlet weak var descriptionTask: UILabel!
  @IBOutlet weak var dateTask: UILabel!
  
  func setCell(item: Task){
    titleTask.text = item.title
    descriptionTask.text = item.description
    dateTask.text = item.deadLine.getDateString()
  }
}
