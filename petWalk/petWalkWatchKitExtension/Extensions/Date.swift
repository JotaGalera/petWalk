//
//  Date.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 27/5/22.
//

import Foundation

extension Date {
    func isToday() -> Bool {
        let calendar = NSCalendar.current
        
        let date1 = calendar.startOfDay(for: .now)
        let date2 = calendar.startOfDay(for: self)
        
        let daysBetweenDates = calendar.dateComponents([.day], from: date1, to: date2).day
        
        return daysBetweenDates == 0
    }
}
