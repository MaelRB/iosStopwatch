//
//  ViewController.swift
//  Stopwatch
//
//  Created by Mael Romanin Bluteau on 02/05/2020.
//  Copyright © 2020 Mael Romanin Bluteau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lapButton: MRBButton!
    @IBOutlet weak var startButton: MRBButton!
    @IBOutlet weak var tableView: UITableView!
    
    var timer = Timer()
    
    var miliSeconds = 0
    var seconds = 0
    var minutes = 0
    
    var miliSecondsCell = 0
    var secondsCell = 0
    var minutesCell = 0
    
    var numberOfLap = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        lapButton.stateButton = .reset
    }

    @IBAction func lapButtonDidTap(_ sender: Any) {
        if lapButton.stateButton == .lap {
            numberOfLap += 1
            // I don't reset this value to sero to limit the offset
            miliSecondsCell = 10
            secondsCell = 0
            minutesCell = 0
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
            tableView.endUpdates()
        } else {
            numberOfLap = 0
            miliSeconds = 0
            seconds = 0
            minutes = 0
            
            miliSecondsCell = 0
            secondsCell = 0
            minutesCell = 0
            timeLabel.text = "00:00.00"
            tableView.reloadData()
        }
    }
    
    @IBAction func startButtonDidTap(_ sender: Any) {
        if numberOfLap == 0 {
            numberOfLap += 1
            lapButton.isEnabled = true
            tableView.reloadData()
        }
        if startButton.stateButton == .start {
            startButton.stateButton = .stop
            lapButton.stateButton = .lap
            timer = Timer.scheduledTimer(withTimeInterval: 0.0165, repeats: true, block: { (_) in
                self.increment()
                self.incrementCell()
                DispatchQueue.main.async {
                    self.updateTimer()
                    self.updateLapCell()
                }
            })
            timer.fire()
        } else {
            startButton.stateButton = .start
            lapButton.stateButton = .reset
            timer.invalidate()
        }
    }
    
    func increment() {
        miliSeconds += 1
        if miliSeconds >= 60 {
            miliSeconds = 0
            seconds += 1
            if seconds >= 60 {
                seconds = 0
                minutes += 1
            }
        }
    }
    
    func incrementCell() {
        miliSecondsCell += 1
        if miliSecondsCell >= 60 {
            miliSecondsCell = 0
            secondsCell += 1
            if secondsCell >= 60 {
                secondsCell = 0
                minutesCell += 1
            }
        }
    }
    
    func updateTimer() {
        var stringMiliSeconds = String(miliSeconds)
        stringMiliSeconds.addZeroToFirstCharIfNeeded()
        var stringSeconds = String(seconds)
        stringSeconds.addZeroToFirstCharIfNeeded()
        var stringMinutes = String(minutes)
        stringMinutes.addZeroToFirstCharIfNeeded()
        
        let time: String = stringMinutes + ":" + stringSeconds + "." + stringMiliSeconds
        timeLabel.text = time
    }
    
    func updateLapCell() {
        var stringMiliSeconds = String(miliSecondsCell)
        stringMiliSeconds.addZeroToFirstCharIfNeeded()
        var stringSeconds = String(secondsCell)
        stringSeconds.addZeroToFirstCharIfNeeded()
        var stringMinutes = String(minutesCell)
        stringMinutes.addZeroToFirstCharIfNeeded()
        
        let time: String = stringMinutes + ":" + stringSeconds + "." + stringMiliSeconds
        tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.detailTextLabel?.text = time
    }
    
}

//MARK: - Table view data source & delegate methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfLap
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.detailTextLabel?.text = "00:00.00"
        cell.textLabel?.text = "Lap \(numberOfLap - indexPath.row)"
        return cell
    }
}



