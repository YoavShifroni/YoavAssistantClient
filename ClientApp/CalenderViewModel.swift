//
//  CalenderViewModel.swift
//  ClientApp
//
//  Created by Yoav Shifroni Udassin on 27/09/2024.
//

import Foundation

@MainActor
class CalendarViewModel : ObservableObject {
    
    @Published var monthsData: [MonthData] = []

    init() {
    }
        
    func fetchData() async {
        guard let downloadedMonthData: [MonthData] = await WebService().downloadData(fromURL: Constants.SERVER_ADDRESS+"/months") else {return}
        self.monthsData = downloadedMonthData
       }
}


/*
 private let months : [MonthData] = [MonthData(numberOfDays: 32, month: "January", numberOfBlanks: 1, monthNumber: 1), MonthData(numberOfDays: 30, month: "February", numberOfBlanks: 4, monthNumber: 2), MonthData(numberOfDays: 32, month: "March", numberOfBlanks: 5, monthNumber: 3), MonthData(numberOfDays: 31, month: "April", numberOfBlanks: 1, monthNumber: 4), MonthData(numberOfDays: 32, month: "May", numberOfBlanks: 3, monthNumber: 5), MonthData(numberOfDays: 31, month: "June", numberOfBlanks: 6, monthNumber: 6), MonthData(numberOfDays: 32, month: "July", numberOfBlanks: 1, monthNumber: 7), MonthData(numberOfDays: 32, month: "August", numberOfBlanks: 4, monthNumber: 8), MonthData(numberOfDays: 31, month: "September", numberOfBlanks: 0, monthNumber: 9), MonthData(numberOfDays: 32, month: "October", numberOfBlanks: 2, monthNumber: 10), MonthData(numberOfDays: 31, month: "November", numberOfBlanks: 5, monthNumber: 11), MonthData(numberOfDays: 32, month: "December", numberOfBlanks: 0, monthNumber: 12)]
 
 */
