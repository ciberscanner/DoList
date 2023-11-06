//
//  GlobalFunctions.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import UIKit
import UserNotifications

//MARK: - Alert
func showOKAlert(title: String, message: String, style: UIAlertController.Style = .alert, view: UIViewController){
  let alert = UIAlertController(title: title, message: message, preferredStyle: style)
  alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
  }))
  view.present(alert, animated: true, completion: nil)
}
//MARK: - Arrays and Strings
func arrayToString<T: Codable>(withCodable codable: [T])-> String{
  let encoder = JSONEncoder()
  let data = try! encoder.encode(codable)
  let string: String? = String(data: data, encoding: .utf8)
  return string ?? ""
}

func stringToArray<T: Codable>(jsonString: String, withCodable codable: T.Type) -> [T]{
  if jsonString.isEmpty{
    return []
  }
  let jsonData = jsonString.data(using: .utf8)!
  let jsonDecoder = JSONDecoder()
  let items = try! jsonDecoder.decode([T].self, from: jsonData)
  return items
}
//MARK: - Notifications
func requestNotificationAuthorization() {
  let userNotificationCenter = UNUserNotificationCenter.current()
  let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
  userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
    if let error = error {
      log(object:"Request Notification error: \(error)")
    }
  }
}

func scheduleNotification(title: String, subtitle: String, reminder: Date) -> Void{
  let content = UNMutableNotificationContent()
  content.title = title
  content.body = subtitle
  let calendar = Calendar.current
  var dateInfo = DateComponents()
  dateInfo.hour = calendar.component(.hour, from: reminder)
  dateInfo.minute = calendar.component(.minute, from: reminder)
  let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
  let request = UNNotificationRequest(identifier: "DoList_\(title)", content: content, trigger: trigger)
  UNUserNotificationCenter.current().add(request) {(error) in
    if let error = error {
      log(object:"Notification error: \(error)")
    }
  }
}
//MARK: - Print if debug
func log(object: Any) {
#if DEBUG
  print(object)
#endif
}
