//
//  DateFormatType.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 22.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import Foundation

enum DateFormatType {
    
    /// The ISO8601 formatted year "yyyy" i.e. 1997
    case isoYear
    
    /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
    case isoYearMonth
    
    /// MMMM yyy i.e. July 2020
    case monthYear
    
    /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
    case isoDate
    
    /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07-16T19:20+01:00
    case isoDateTime
    
    /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07-16T19:20:30+01:00
    case isoDateTimeSec
    
    /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 1997-07-16T19:20:30.45+01:00
    case isoDateTimeMilliSec
    
    /// The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
    case dotNet
    
    /// The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
    case rss
    
    /// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
    case altRSS
    
    /// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
    case httpHeader
    
    /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
    case standard
    
    /// A custom date format string
    case custom(String)
    
    /// The ISO8601 formatted date, "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    case iso8601
    
    /// Time formated date, "dd MMM yyyy"
    case timeFormat
    
    /// HH:mm "21:00"
    case timeShort
    
    /// HH:mm a "22:55 PM"
    case timeShortPostfix
    
    /// hh:mm:ss
    case time
    
    /// Month name
    case month
    
    /// Year
    case year
    
    /// yyyy-MM-dd i.e. 2021-08-21
    case yearMonthDay
    
    var format: String {
        
        switch self {
        case .isoYear: return "yyyy"
        case .isoYearMonth: return "yyyy-MM"
        case .isoDate: return "yyyy-MM-dd"
        case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
        case .isoDateTimeSec: return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .isoDateTimeMilliSec: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .dotNet: return "/Date(%d%f)/"
        case .rss: return "EEE, d MMM yyyy HH:mm:ss ZZZ"
        case .altRSS: return "d MMM yyyy HH:mm:ss ZZZ"
        case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
        case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
        case .iso8601: return "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        case .custom(let customFormat): return customFormat
        case .timeFormat: return "d MMM yyyy"
        case .timeShort: return "HH:mm"
        case .timeShortPostfix: return "HH:mm a"
        case .time: return "hh:mm:ss"
        case .monthYear: return "MMMM yyy"
        case .month: return "MMMM"
        case .year: return "yyyy"
        case .yearMonthDay: return "yyyy-MM-dd"
        }
    }
    
}
