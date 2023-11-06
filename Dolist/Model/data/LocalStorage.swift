//
//  LC.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import Foundation
import UIKit

public class LC{
  //--------------------------------------------------------------------
  //Variables
  private let defaults: UserDefaults
  private let KEYTASK = "KeyTaskArray"
  private let fileM = DoFile()
  //--------------------------------------------------------------------
  //
  init(defaults: UserDefaults = .standard) {
      self.defaults = defaults
  }
  //--------------------------------------------------------------------
  //
  func addTask(item: Task){
    var tasks = getTasks()
    tasks.append(item)
    saveTasks(items: tasks)
    let dateLessTen = item.deadLine.getDate().addMinutes(minutes: -10)
    scheduleNotification(title: item.title, subtitle: item.description, reminder: dateLessTen)
  }
  func updateTask(item: Task){
    var tasks = getTasks()
    if let row = tasks.firstIndex(where: {$0.id == item.id}) {tasks[row] = item}
    saveTasks(items: tasks)
  }
  func deleteTask(item: Task){
    let filter = getTasks().filter{ $0.id != item.id}
    saveTasks(items: filter)
  }
  func deleteTasks(items: [Task]){
    for item in items{
      deleteTask(item: item)
    }
  }
  func completeTasks(items: [Task]){
    for item in items{
      var aux = item
      aux.status = .ready
      updateTask(item: aux)
    }
  }
  func saveTasks(items: [Task]){
    /**let data = items.map { try? JSONEncoder().encode($0) }
    defaults.set(data, forKey: KEYTASK)*/
    let jsonString = arrayToString(withCodable: items)
    fileM.write(text: jsonString)
  }
  func getTasks()->[Task]{
    /**guard let encodedData = UserDefaults.standard.array(forKey: KEYTASK) as? [Data] else {return []}
    return encodedData.map { try! JSONDecoder().decode(Task.self, from: $0) }*/
    let jsonString = fileM.read()
    let items = stringToArray(jsonString: jsonString, withCodable: Task.self)
    return items
  }
  func getTasksWithLateTask() ->[Task]{
    var tasks = getTasks()
    if tasks.count == 0{
      return []
    }
    let now = Date()
    for i in 0...tasks.count-1{
      if(tasks[i].deadLine.getDate() < now && tasks[i].status != .ready){
        tasks[i].status = .late
      }
    }
    return tasks
  }
}
