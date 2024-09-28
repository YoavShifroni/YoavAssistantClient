//
//  MeetingDataModel.swift
//  ClientApp
//
//  Created by Yoav Shifroni Udassin on 02/11/2024.
//



import Foundation

@MainActor
class MeetingDataModel : ObservableObject {
    
    @Published var mettingData: [MeetingData] = []

    init() {
    }
        
    func fetchData(day: Int, month: Int, year: Int) async {

        let url = Constants.SERVER_ADDRESS+"/meetings?day=\(day)&month=\(month)&year=\(year)"
        guard let downloadedMeetingData: [MeetingData] = await WebService().downloadData(fromURL: url) else {return}
        print(downloadedMeetingData)
        self.mettingData = downloadedMeetingData
        
    }
}
