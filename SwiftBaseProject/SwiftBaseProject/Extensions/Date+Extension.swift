//
//  Date+Extension.swift
//  ineocoin
//
//  Created by Huy Lam on 12/12/17.
//  Copyright © 2017 Engie Ineo. All rights reserved.
//

import Foundation
extension Date {
    // MARK: - Date Earlier/Later
    
    /**
     *  Return the earlier of two dates, between self and a given date.
     *
     *  - parameter date: The date to compare to self
     *
     *  - returns: The date that is earlier
     */
    public func earlierDate(_ date:Date) -> Date{
        return (self.timeIntervalSince1970 <= date.timeIntervalSince1970) ? self : date
    }
}
extension Date {
    func timeAgoSinceDate() -> String {
        
        let calendar = NSCalendar.current
        let unitFlags = Set<Calendar.Component>([.second,.minute,.hour,.day,.weekOfYear,.month,.year])
        let earliest = self.earlierDate(Date())
        let latest = (earliest == self) ? Date() : self //Should be triple equals, but not extended to Date at this time
        
        let components = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        
        let isYesterday = Calendar.current.isDateInYesterday(self)
        
        if (components.year! >= 2) {
            return String(format: NSLocalizedString("%@ ago", comment: ""), "\(components.year!) \(NSLocalizedString("year", comment: ""))s")
        } else if (components.year! >= 1){
            return String(format: NSLocalizedString("%@ ago", comment: ""), "1 \(NSLocalizedString("year", comment: ""))")
        } else if (components.month! >= 2) {
            return String(format: NSLocalizedString("%@ ago", comment: ""), "\(components.month!) \(NSLocalizedString("months", comment: ""))")
        } else if (components.month! >= 1){
            return String(format: NSLocalizedString("%@ ago", comment: ""), "1 \(NSLocalizedString("month", comment: ""))")
        } else if (components.weekOfYear! >= 2) {
            return String(format: NSLocalizedString("%@ ago", comment: ""), "\(components.weekOfYear!) \(NSLocalizedString("week", comment: ""))s")
        } else if (components.weekOfYear! >= 1){
            return String(format: NSLocalizedString("%@ ago", comment: ""), "1 \(NSLocalizedString("week", comment: ""))")
        } else if (components.day! >= 2) {
            return String(format: NSLocalizedString("%@ ago", comment: ""), "\(components.day!) \(NSLocalizedString("day", comment: ""))s")
        } else if (isYesterday) {
            return String(format: NSLocalizedString("yesterday", comment: ""))
        } else if (components.hour! >= 2) {
            return String(format: NSLocalizedString("%@ ago", comment: ""), "\(components.hour!) \(NSLocalizedString("hour", comment: ""))s")
        } else if (components.hour! >= 1) {
            return String(format: NSLocalizedString("%@ ago", comment: ""), "1 \(NSLocalizedString("hour", comment: ""))")
        } else if (components.minute! >= 2) {
            return String(format: NSLocalizedString("%@ ago", comment: ""), "\(components.minute!) minutes")
        } else if (components.minute! >= 1){
            return String(format: NSLocalizedString("%@ ago", comment: ""), "1 minute")
        } else if (components.second! >= 3) {
            return String(format: NSLocalizedString("%@ ago", comment: ""), "\(components.second!) \(NSLocalizedString("seconds", comment: ""))")
        } else {
            return NSLocalizedString("now", comment: "")
        }
    }
    
    func toMilisecond() -> Double {
        return self.timeIntervalSince1970 * 1000.0
    }
    
    static func fromMilisecond(_ milis: Double) -> Date {
        return Date(timeIntervalSince1970: milis / 1000)
    }
    
    private func getDateNow() -> Date?  {
        return nil
    }
    
    func stringSorted() -> String {
        var sortedString = ""
        if self.fs_isDateToday() {
            sortedString = " \(NSLocalizedString("today", comment: "").uppercased())"
        } else {
            sortedString = " \(NSLocalizedString("previous_days", comment: "").uppercased())"
        }
        return sortedString
    }
    
    func convertToString(format: String = Constants.DateFormat.long) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var tomorrow: Date {
        return fs_tomorrow
    }
}
