    //
//  AddAlarmViewController.swift
//  TestAlarm
//
//  Created by Franklin Samboni on 3/11/20.
//

import UIKit

class AddAlarmViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    private var presenter: AddAlarmPresenter!
    
    var alarm: Alarm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddAlarmPresenter(alarm: alarm)
        setupUI()
    }
    
    @IBAction func onSaveTap(_ sender: Any) {
        guard validForm() else {
            showAlertMessage(title: "Nombre requerido", message: "Ingresa un nombre")
            return
        }
        presenter.saveAlarm(title: titleTextField.text ?? "",
                            description: descriptionTextField.text,
                            date: datePicker.date)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onDeleteTap(_ sender: Any) {
        presenter.removeAlarm()
        navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        deleteButton.isHidden = alarm == nil
        titleTextField.text = alarm?.name
        descriptionTextField.text = alarm?.description
        datePicker.date = alarm?.date ?? Date()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.minimumDate = Date()
    }
    
    func validForm() -> Bool {
        guard titleTextField.text != nil && titleTextField.text != "" else {
            return false
        }
        return true
    }

}
