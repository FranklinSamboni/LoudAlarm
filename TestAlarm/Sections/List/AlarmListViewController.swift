//
//  ViewController.swift
//  TestAlarm
//
//  Created by Franklin Samboni on 3/11/20.
//

import UIKit

protocol AlarmListView: class {
    func updateAlarms()
}

class AlarmListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let showAddAlarmSegue = "showAddAlarm"
    
    var presenter: AlarmListPresenter!
    var alarms: [Alarm] = []
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AlarmListPresenter()
        tableView.dataSource = self
        tableView.delegate = self
        
        requestAuthorization()
        handleLocalNotification()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleLocalNotification), name: Notification.Name.LocalNotificationOpen, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alarms = presenter.getAlarms()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAddAlarmSegue {
            let vc = segue.destination as! AddAlarmViewController
            vc.alarm = sender as? Alarm
        }
    }
    
    @IBAction func onShowAddAlarmTap(_ sender: Any) {
        performSegue(withIdentifier: showAddAlarmSegue, sender: nil)
    }
    
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if !granted {
                self.showAlertMessage(title: "Permiso requerido", message: "Se requiere de las notificaciones para mostrar alertas")
            }
        }
    }
}

extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmItemTableViewCell", for: indexPath) as! AlarmItemTableViewCell
        let item = alarms[indexPath.row]
        cell.setup(alarm: item, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = alarms[indexPath.row]
        performSegue(withIdentifier: showAddAlarmSegue, sender: item)
    }
    
}

extension AlarmListViewController {
    
    @objc func handleLocalNotification() {
        
        guard let notification = Application.shared.localNotification else {
            return
        }
        
        Application.shared.localNotification = nil
        
        let identifier = notification.request.identifier
        if let presenter = presenter {
            presenter.disableAlarm(notificationId: identifier)
            tableView.reloadData()
        }
    }
}

extension AlarmListViewController: AlarmItemDelegate {
    func onEnableStateChange(alarm: Alarm, isEnable: Bool) {
        if isEnable {
            presenter.enableAlarm(alarm: alarm)
        } else {
            presenter.disableAlarm(alarm: alarm)
        }
        tableView.reloadData()
    }
}
