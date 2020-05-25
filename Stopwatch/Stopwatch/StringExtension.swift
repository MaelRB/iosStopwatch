//
//  StringExtension.swift
//  Stopwatch
//
//  Created by Mael Romanin Bluteau on 02/05/2020.
//  Copyright © 2020 Mael Romanin Bluteau. All rights reserved.
//

import Foundation

extension String {
    
    mutating func addZeroToFirstCharIfNeeded() {
        if self.count == 1 {
            self.append("0")
            self.reverse()
        }
    }
    
    mutating func reverse() {
        let reversedCharacter = self.reversed()
        self = ""
        for char in reversedCharacter {
            self.append(char)
        }
    }
}
