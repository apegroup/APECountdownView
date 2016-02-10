//
//  StringExtensions.swift
//  Countdown
//
//  Created by Daniel Nilsson on 06/11/15.
//  Copyright © 2015 Daniel Nilsson. All rights reserved.
//

import UIKit

extension String {
    func getFirstChar() -> String {
        if (self.characters.count == 0) {
            return self
        }
        
        return self[Range(start: self.startIndex, end: self.startIndex.advancedBy(1))]
    }
    
    func getLastChar() -> String {
        if (self.characters.count == 0) {
            return self
        }
        
        return self[Range(start: self.endIndex.advancedBy(-1), end: self.endIndex)]
    }
}
