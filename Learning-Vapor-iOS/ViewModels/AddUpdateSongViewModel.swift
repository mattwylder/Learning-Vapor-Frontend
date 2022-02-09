//
//  AddUpdateSongViewModel.swift
//  Learning-Vapor-iOS
//
//  Created by Matthew Wylder on 2/9/22.
//

import Foundation

final class AddUpdateSongViewModel: ObservableObject {
    
    @Published var songTitle = ""
    var songID: UUID?
    
    var isUpdating: Bool {
        songID != nil
    }
    
    var buttonTitle: String {
        songID != nil ? "Update Song" : "Add Song"
    }
    
    init() {}
    init(currentSong: Song) {
        self.songTitle = currentSong.title
        self.songID = currentSong.id
    }
    
    func addSong() async throws {
        guard let url = URL(string: "http://127.0.0.1:8080/songs") else {
            throw HTTPError.badURL
        }
        
        let song = Song(id: nil, title: songTitle)
        
        try await HTTPClient.shared.sendData(to: url,
                                             object: song,
                                             httpMethod: HttpMethod.POST.rawValue)
    }
    
    func addUpdateAction(completion: @escaping ()-> Void) {
        Task {
            do {
                if self.isUpdating {
                    //updateSong()
                } else {
                    try await addSong()
                }
            } catch {
                print("Error: \(error)")
            }
            completion()
        }
    }
}
