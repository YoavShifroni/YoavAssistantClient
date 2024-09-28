//
//  MeetingData.swift
//  ClientApp
//
//  Created by Yoav Shifroni Udassin on 09/08/2024.
//

import Foundation

struct MeetingData : Identifiable, Hashable, Codable{
    let id : Int
    let beginHour : Int
    let beginMinute : Int
    let endHour : Int
    let endMinute : Int
    let data : String
    
}
