//
//  WebService.swift
//  ClientApp
//
//  Created by Yoav Shifroni Udassin on 27/09/2024.
//

import Foundation


class WebService: Codable {
    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL) else { print("There was an error creating the URL"); return nil}
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { print("Did not get a valid response"); return nil}
            guard response.statusCode == 200 else { print("Did not get HTTP 200 reponse"); return nil}
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { print("Cannot decode reponse", data); return nil}
            return decodedResponse
        } catch let error{
            print("An error occured downloading the data", error)
        }
        
        return nil
    }
}

