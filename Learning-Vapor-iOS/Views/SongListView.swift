//
//  SongListView.swift
//  Learning-Vapor-iOS
//
//  Created by Matthew Wylder on 2/9/22.
//

import SwiftUI

struct SongListView: View {
    @StateObject var viewModel = SongViewModel()
    
    @State var modal: ModalType? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.songs) { song in
                    Button {
                        print("selected")
                    } label: {
                        Text(song.title)
                            .font(.title3)
                            .foregroundColor(Color(.label))
                    }
                    
                }
            }
            .navigationTitle(Text("Songs"))
            .toolbar {
                Button {
                    modal = .add
                } label: {
                    Label("Add Song", systemImage: "plus.circle")
                }
            }
        }
        .sheet(item: $modal) {
            Task {
                do {
                    try await viewModel.fetchSongs()
                } catch {
                    print(error)
                }
            }
        } content: { modal in
            // TODO: Oh yikes this should go to a presenter - 2/9/22
            switch modal {
            case .add:
                AddUpdateSongView(viewModel: AddUpdateSongViewModel())
            case .update( let song):
                AddUpdateSongView(viewModel: AddUpdateSongViewModel(currentSong: song))
            }
        }
        .onAppear {
            //TODO: I don't like throwing up to the view - 2/9/22
            Task {
                do {
                    try await viewModel.fetchSongs()
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView()
    }
}
