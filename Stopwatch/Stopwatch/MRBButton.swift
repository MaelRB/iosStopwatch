//
//  MRBButton.swift
//  Stopwatch
//
//  Created by Mael Romanin Bluteau on 02/05/2020.
//  Copyright © 2020 Mael Romanin Bluteau. All rights reserved.
//

import UIKit

class MRBButton: UIButton {
    
    enum StateButton {
        case start
        case stop
        case lap
        case reset
    }
    
    var stateButton: StateButton = .start {
        didSet {
            switch self.stateButton {
                case     .start: stopToStart()
                case     .stop: startToStop()
                case .lap: self.setTitle("Lap", for: .normal)
                case .reset: self.setTitle("Reset", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    fileprivate func setupUI() {
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func startToStop() {
        self.setTitle("Stop", for: .normal)
        self.setTitleColor(UIColor(displayP3Red: 1, green: 0.493, blue: 0.474, alpha: 1), for: .normal)
        self.backgroundColor = UIColor(displayP3Red: 0.581, green: 0.067, blue: 0, alpha: 1)
    }
    
    func stopToStart() {
        self.setTitle("Start", for: .normal)
        self.setTitleColor(UIColor(displayP3Red: 0.451, green: 0.980, blue: 0.475, alpha: 1), for: .normal)
        self.backgroundColor = UIColor(displayP3Red: 0, green: 0.560, blue: 0, alpha: 1)
    }
    
}
