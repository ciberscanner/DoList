//
//  HomeViewController.swift
//  Dolist
//
//  Created by Diego Fernando Serna Salazar on 4/11/23.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {
  //--------------------------------------------------------------------
  //Variables
  @IBOutlet weak var segmentList: UISegmentedControl!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var imageBack: UIImageView!
  @IBOutlet weak var textImage: UILabel!
  @IBOutlet weak var hContentButtons: NSLayoutConstraint!
  @IBOutlet weak var contentButtons: UIView!
  private var listTask:[Task] = []
  private var selectedItems = [Task]()
  private var filter = StatusTask.pending
  private let local = LC()
  //--------------------------------------------------------------------
  //Constructor
  override func viewDidLoad() {
    super.viewDidLoad()
    self.addLogoToNavigationBarItem()
    self.hideKeyboardWhenTappedAround()
    setView()
    requestNotificationAuthorization()
  }
  func setView(){
    tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    tableView.allowsMultipleSelectionDuringEditing = true
    refreshTable()
    addButton.clipsToBounds = true
    addButton.setTitle("", for: .normal)
    addButton.contentMode = .scaleAspectFill
    addButton.setImage(UIImage(named: "add.png"), for: .normal)
    addButton.setImage(UIImage(named: "agregar"), for: .selected)
    hContentButtons.constant = 0
    contentButtons.isHidden = true
  }
  @IBAction func addAction(_ sender: Any) {
    let newTask = NewTask(frame: CGRect(x: 0, y: 20, width: view.bounds.width, height: view.bounds.height))
    newTask.setView(view: self, action: refreshTable)
    view.addSubview(newTask)
  }
  @IBAction func editAction(_ sender: Any) {
    tableView.setEditing(!tableView.isEditing, animated: true)
    if tableView.isEditing{
      hContentButtons.constant = 65
      contentButtons.isHidden = false
    }else{
      hContentButtons.constant = 0
      contentButtons.isHidden = true
    }
  }
  @IBAction func segmentAction(_ sender: Any) {
    switch segmentList.selectedSegmentIndex {
    case 0:
      filter = StatusTask.pending
      imageBack.image = nil
      imageBack.image = UIImage(named: "desierto")
      textImage.text = "“No hay elementos para mostrar. Presione “Agregar” para agregar nuevos elementos”"
    case 1 :
      filter = StatusTask.ready
      imageBack.image = nil
      imageBack.image = UIImage(named: "desierto")
      textImage.text = "“No hay elementos para mostrar. Presione “Agregar” para agregar nuevos elementos”"
    case 2:
      filter = StatusTask.late
      imageBack.image = nil
      imageBack.image = UIImage(named: "goodJob")
      textImage.text = "Buen trabajo, no tienes tareas atrasadas"
    default:
      break
    }
    tableView.reloadData()
    selectedItems.removeAll()
  }
  @IBAction func deleteMultipleAction(_ sender: Any) {
    if selectedItems.count == 0{
      showOKAlert(title: "Atención", message: "No ha seleccionado elementos para eliminar", view: self)
      return
    }
    local.deleteTasks(items: selectedItems)
    refreshTable()
    editAction(self)
  }
  @IBAction func completeMultipleAction(_ sender: Any) {
    if selectedItems.count == 0{
      showOKAlert(title: "Atención", message: "No ha seleccionado elementos para completar", view: self)
      return
    }
    local.completeTasks(items: selectedItems)
    refreshTable()
    editAction(self)
  }
}
//MARK: - Protocol
extension HomeViewController: HomeView{
  func updateTable(items: [Task]) {
    listTask = items
    tableView.reloadData()
  }
  func refreshTable() {
    listTask = local.getTasksWithLateTask()
    tableView.reloadData()
  }
}
//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if !tableView.isEditing{
      let newTask = NewTask(frame: CGRect(x: 0, y: 20, width: view.bounds.width, height: view.bounds.height))
      newTask.show(view: self, task: listTask.filter{$0.status == filter}[indexPath.row], action: refreshTable)
      view.addSubview(newTask)
    }else{
      if let paths = tableView.indexPathsForSelectedRows {
        var auxList = [Task]()
        for path in paths {
          auxList.append(listTask.filter{$0.status == filter}[path.row])
        }
        selectedItems = auxList
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    if let paths = tableView.indexPathsForSelectedRows {
      var auxList = [Task]()
      for path in paths {
        auxList.append(listTask.filter{$0.status == filter}[path.row])
      }
      selectedItems = auxList
    }else{
      selectedItems.removeAll()
    }
  }
  
  func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
    self.setEditing(true, animated: true)
  }
  
  func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
    //print("\(#function)")
  }
}
//MARK: - UITableDataSource
extension HomeViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = (tableView.getReusableCell() as TaskTableViewCell)
    cell.setCell(item: listTask.filter{$0.status == filter}[indexPath.row])
    let bgColorView = UIView()
    bgColorView.backgroundColor =  .systemGray6
    cell.selectedBackgroundView = bgColorView
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let counter = listTask.filter{$0.status == filter}.count
    tableView.isHidden = (counter == 0)
    return counter
  }
}
