//
//  AddUpdateSong.swift
//  Learning-Vapor-iOS
//
//  Created by Matthew Wylder on 2/9/22.
//

import SwiftUI

struct AddUpdateSongView: View {
    
    @ObservedObject var viewModel: AddUpdateSongViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("song title", text: $viewModel.songTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button {
                viewModel.addUpdateAction {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text(viewModel.buttonTitle)
            }
        }
    }
}


struct AddUpdateSong_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateSongView(viewModel: AddUpdateSongViewModel())
    }
}
