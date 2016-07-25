


//: Playground - noun: a place where people can play


import UIKit


func isLeap(year: Int) -> Bool {
    return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
}



func julianDate(year: Int, month: Int, day: Int) -> Int{
    let daysInYear = [31, isLeap(year) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][0..<month-1].reduce(0, combine: + )
    let daysInPreviousYears = (1900..<year).map({isLeap($0) ? 366 : 365}).reduce(0, combine: +)
    return day + daysInYear + daysInPreviousYears
}





// Required tests

julianDate(1960, month:  9, day: 28)
julianDate(1900, month:  1, day: 1)
julianDate(1900, month: 12, day: 31)
julianDate(1901, month: 1, day: 1)
julianDate(1901, month: 1, day: 1) - julianDate(1900, month: 1, day: 1)
julianDate(2001, month: 1, day: 1) - julianDate(2000, month: 1, day: 1)

isLeap(1960)
isLeap(1900)
isLeap(2000)






















