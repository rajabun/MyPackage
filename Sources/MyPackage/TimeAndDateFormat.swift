//
//  TimeAndDateFormat.swift
//
//  Created by Priharsanto, Muhammad Rajab on 15/05/25.
//

import Foundation

public enum DateFormat {
    ///date format: dd-MM-yyyy HH:mm:ss
    case fullDateWithTime
    
    ///date format: dd-MM-yyyy HH:mm
    case fullDateWithHourAndMinute
    
    ///date format: dd-MM-yyyy
    case fullDate
    
    ///date format: dd MMMM yyyy
    case fullDateComplete
    
    ///date format: EEEE dd MMMM yyyy
    case fullDateCompleteWithWeekday
    
    ///date format: yyyy
    case year
    
    ///date format: dd MMM
    case dateAndMonth
    
    ///date format: dd MMM yyyy
    case dateMonthAndYear
    
    ///date format: yyyy-MM-dd'T'HH:mm:ss.SSSZ
    case fullDateWithTimezone
    
    ///date format: yyyy-MM-dd'T'HH:mm:ssZ
    case fullDateWithTimezoneWithoutSSS
    
    ///date format: yyyy-MM-dd'T'HH:mm:ss.SSZ
    case fullDateWithTimezoneWithSS
    
    ///date format: yyyyMMdd_HHmmss
    case uploadImageFileName
    
    case custom(format: String)
}

public func dateFromString(string: String, format: DateFormat = .fullDate) -> Date {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "id_ID")
    formatter.timeZone = TimeZone.autoupdatingCurrent
    switch format {
    case .fullDateWithTime:
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    case .fullDateWithHourAndMinute:
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
    case .fullDate:
        formatter.dateFormat = "dd-MM-yyyy"
    case .fullDateComplete:
        formatter.dateFormat = "dd MMMM yyyy"
    case .fullDateCompleteWithWeekday:
        formatter.dateFormat = "EEEE dd MMMM yyyy"
    case .year:
        formatter.dateFormat = "yyyy"
    case .dateAndMonth:
        formatter.dateFormat = "dd MMM"
    case .dateMonthAndYear:
        formatter.dateFormat = "dd MMM yyyy"
    case .fullDateWithTimezone:
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case .fullDateWithTimezoneWithoutSSS:
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case .fullDateWithTimezoneWithSS:
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
    case .uploadImageFileName:
        formatter.dateFormat = "yyyyMMdd_HHmmss"
    case .custom(let format):
        formatter.dateFormat = format
    }
    return formatter.date(from: string) ?? Date()
}

public func getCurrentDateTime(date: Date = Date(), format: DateFormat = .fullDateWithTime) -> String {
    let formatter = DateFormatter()
    
    formatter.locale = Locale(identifier: "id_ID")
    switch format {
    case .fullDateWithTime:
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    case .fullDateWithHourAndMinute:
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
    case .fullDate:
        formatter.dateFormat = "dd-MM-yyyy"
    case .fullDateComplete:
        formatter.dateFormat = "dd MMMM yyyy"
    case .fullDateCompleteWithWeekday:
        formatter.dateFormat = "EEEE dd MMMM yyyy"
    case .year:
        formatter.dateFormat = "yyyy"
    case .dateAndMonth:
        formatter.dateFormat = "dd MMM"
    case .dateMonthAndYear:
        formatter.dateFormat = "dd MMM yyyy"
    case .fullDateWithTimezone:
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case .fullDateWithTimezoneWithoutSSS:
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case .fullDateWithTimezoneWithSS:
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
    case .uploadImageFileName:
        formatter.dateFormat = "yyyyMMdd_HHmmss"
    case .custom(let format):
        formatter.dateFormat = format
    }
    return formatter.string(from: date)
}

public func dateFromApiToString(string: String,
                         inputFormat: DateFormat = .fullDate,
                         outputFormat: DateFormat = .fullDateWithTime) -> String {
    let inputDate = dateFromString(string: string, format: inputFormat)
    let outputDate = getCurrentDateTime(date: inputDate, format: outputFormat)
    return outputDate
}
