//
//  SongViewModel.swift
//  Learning-Vapor-iOS
//
//  Created by Matthew Wylder on 2/9/22.
//

import Foundation

class SongViewModel: ObservableObject {
    @Published var songs = [Song]()
    
    
    // TODO: I don't think I like throwing up to the View - 2/9/22
    func fetchSongs() async throws {
        // tutorial suggested using ngrok to redirect localhost but this is better for now
        guard let url = URL(string: "http://127.0.0.1:8080/songs") else {
            throw HTTPError.badURL
        }
        
        let songResponse: [Song] = try await HTTPClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.songs = songResponse
        }
    }
}
