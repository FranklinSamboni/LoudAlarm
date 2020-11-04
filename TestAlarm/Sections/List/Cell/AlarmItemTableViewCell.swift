//
//  AlarmItemTableViewCell.swift
//  TestAlarm
//
//  Created by Franklin Samboni on 3/11/20.
//

import UIKit

protocol AlarmItemDelegate: class {
    func onEnableStateChange(alarm: Alarm, isEnable: Bool)
}

class AlarmItemTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var enableSwitch: UISwitch!
    
    weak var delegate: AlarmItemDelegate?
    var alarm: Alarm?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(alarm: Alarm, delegate: AlarmItemDelegate) {
        self.alarm = alarm
        self.delegate = delegate
        
        enableSwitch.isOn = alarm.enabled
        alarmTitleLabel.text = alarm.name
        descriptionLabel.text = alarm.description
        dateLabel.text = alarm.getFormattedDate()
        hourLabel.text = alarm.getFormattedHour()
    }
    
    @IBAction func onEnableStateChange(_ sender: Any) {
        if let alarm = alarm, let delegate = delegate {
            delegate.onEnableStateChange(alarm: alarm, isEnable: enableSwitch.isOn)
        }
    }
    
}
