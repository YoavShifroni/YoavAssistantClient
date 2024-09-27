//
//  ContentView.swift
//  ClientApp
//
//  Created by Yoav Shifroni Udassin on 21/06/2024.
//

import SwiftUI
import Foundation

struct CalenderView: View {
    private let color  = Color.red
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    private let numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    
    private let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    @EnvironmentObject private var model: CalendarViewModel

    var body: some View {
        NavigationView{
            VStack {
                Text("2024")
                    .foregroundColor(.indigo)
                    .font(.system(size: 24, weight: .medium, design: .rounded))
                LazyVGrid(columns: numberColumns, spacing: 20){
                    ForEach(days, id: \.self){ day in
                        ZStack{
                            Rectangle()
                                .frame(width: 40, height: 60)
                                .foregroundColor(.clear)
                            Text("\(day)")
                                .foregroundColor(.black)
                                .font(.system(size: 22, weight: .medium, design: .rounded))
                        }
                    }
                }
                ScrollView  {
                    ForEach(model.monthsData, id: \.self){ month in
                        Spacer(minLength: 30)
                        Text(month.month)
                            .foregroundColor(.black)
                            .font(.system(size: 30,weight: .medium, design: .rounded))
                            LazyVGrid(columns: numberColumns, spacing: 20){
                                ForEach(0..<month.numberOfBlanks) { rr in
                                    ZStack{
                                        Rectangle()
                                            .frame(width: 40, height: 60)
                                            .foregroundColor(.clear)
                                    }
                                }
                                ForEach(1..<month.numberOfDays, id: \.self){ number in
                                    NavigationLink(destination: OpenDayView(day : number, month: month.monthNumber, year : 2024)){
                                        ZStack{
                                            Rectangle()
                                                .frame(width: 40, height: 60)
                                                .foregroundColor(getBackgroundColor(day: number, month: month.monthNumber, year: 2024))
                                            Text("\(number)")
                                                .foregroundColor(getColor(day: number, month: month.monthNumber, year: 2024))
                                                .font(.system(size: 20, weight: .medium, design: .rounded))
                                                
                                        }
                                    }
                                }
                            }
                        
                    }
                }.padding()
                .task {
                    await model.fetchData()
                }
            }
        }
    }
    private func getBackgroundColor(day: Int, month : Int, year : Int) -> Color {
        let calender = Calendar.current
        let currentDay = calender.component(.day, from: Date())
        let currentMonth = calender.component(.month, from: Date())
        let currentYear = calender.component(.year, from: Date())
        if(day == currentDay && month == currentMonth && year == currentYear){
            return .red
        }
        return .clear
    }
    
    
    private func getColor(day: Int, month : Int, year : Int) -> Color{
        let calender = Calendar.current
        let currentDay = calender.component(.day, from: Date())
        let currentMonth = calender.component(.month, from: Date())
        let currentYear = calender.component(.year, from: Date())
        if(day == currentDay && month == currentMonth && year == currentYear){
            return .white
        }
        return .black
    }
}

struct OpenDayView : View{
    let day : Int
    let month : Int
    let year : Int 
    private let data : [MeetingData] = [MeetingData(beginHour: 15,beginMinute: 10,endHour: 16, endMinute: 15,data: "היי מה קורה אחשלי"), MeetingData(beginHour: 18,beginMinute: 35,endHour: 20,endMinute: 12,data: "הילד קפץ מעל הבריכה ונחת בתוך גוש גדול של עלים")]
    
    init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    
    var body : some View{
        NavigationView{
            VStack{
                Spacer()
                Text("Things you have in this day:")
                    .foregroundColor(.gray)
                    .font(.system(size: 24, weight: .medium, design: .rounded))
                List(data) { meeting in
                    NavigationLink(destination: EmptyView()){
                        HStack{
                            Text("\(meeting.beginHour):\(meeting.beginMinute)")
                            Text(" - \(meeting.endHour):\(meeting.endMinute)")
                            Spacer()
                            Text("\(meeting.data) ")
                                .multilineTextAlignment(.trailing)
                        
                        }
                    }
                }
                .navigationTitle(Text(createDate(year: year, month: month, day: day).formatted(date: .complete, time: .omitted)))
                .toolbar(){
                    ToolbarItem{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                            Image(systemName: "plus")
                                .resizable()
                                .padding(6)
                                .background(Color.blue)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
    
    func createDate(year: Int, month : Int, day: Int) -> Date{
        let calendar = Calendar.current
        var dateComonents = DateComponents()
        dateComonents.year = year
        dateComonents.month = month
        dateComonents.day = day
        let date = calendar.date(from: dateComonents)!
        return date

    }
}

struct AddEventView : View {
    var body: some View {
        NavigationView{
            VStack{
                
            }
        }
    }
}
#Preview {
    CalenderView()
}
