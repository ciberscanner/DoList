//
//  NewTask.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import UIKit

@IBDesignable
class NewTask: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var titleView: UILabel!
  @IBOutlet weak var titleTask: UITextField!
  @IBOutlet weak var descriptionTask: UITextField!
  @IBOutlet weak var deadLineTask: UIDatePicker!
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var centerButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  private var isEditing = false
  private let local = LC()
  private var task: Task?
  
  var view: UIViewController!
  fileprivate var action: (() -> Void)?
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initSubviews()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initSubviews()
  }
  
  func initSubviews() {
    let nib = UINib(nibName: "NewTask", bundle: nil)
    nib.instantiate(withOwner: self, options: nil)
    contentView.frame = bounds
    addSubview(contentView)
    titleTask.delegate = self
    descriptionTask.delegate = self
    deadLineTask.locale = .current
    deadLineTask.datePickerMode = .dateAndTime
    deadLineTask.calendar.locale = .current
    deadLineTask.timeZone = .current
    deadLineTask.tintColor = .systemBlue
    deadLineTask.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
  }
  
  func setView(view: UIViewController,action: (() -> Void)? = nil){
    self.action = action
    centerButton.isHidden = true
    self.view = view
  }
  
  func show(view: UIViewController,task: Task, action: (() -> Void)? = nil){
    self.action = action
    self.view = view
    self.task = task
    titleView.text = "Editar / Eliminar"
    titleTask.text = task.title
    descriptionTask.text = task.description
    leftButton.setTitle("Eliminar", for: .normal)
    //rightButton.setTitle("Aceptar", for: .normal)
    isEditing = true
    if task.status == .ready{
      centerButton.isHidden = true
    }
    
    let dateX = NSDate(timeIntervalSince1970: task.deadLine) as Date
    deadLineTask.locale = .current
    deadLineTask.datePickerMode = .dateAndTime
    deadLineTask.calendar.locale = .current
    deadLineTask.timeZone = .current
    deadLineTask.tintColor = .systemBlue
    deadLineTask.minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
    deadLineTask.setDate(dateX, animated: true)
    
  }
  @IBAction func completeAction(_ sender: Any) {
    task?.title = titleTask.text!
    task?.description = descriptionTask.text!
    task?.status = .ready
    local.updateTask(item: task!)
    closeView()
  }
  
  @IBAction func cancelAction(_ sender: Any) {
    if isEditing{
      local.deleteTask(item: task!)
    }
    closeView()
  }
  
  @IBAction func acceptAction(_ sender: Any) {
    if titleTask.text!.isEmpty{
      showOKAlert(title: "Atención", message: "El título es un campo obligatorio", view: view)
      return
    }
    if isEditing{
      task?.title = titleTask.text!
      task?.description = descriptionTask.text!
      local.updateTask(item: task!)
    }else{
      let comp = deadLineTask.calendar.dateComponents([.hour, .minute], from: deadLineTask.date)
      local.addTask(item: Task(title: titleTask.text!, description: descriptionTask.text!, deadLine: deadLineTask.date.timeIntervalSince1970))
    }
    closeView()
  }
  private func closeView(){
    action?()
    self.removeFromSuperview()
  }
}

//MARK: -UITextField
extension NewTask: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
      nextField.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    return false
  }
}
