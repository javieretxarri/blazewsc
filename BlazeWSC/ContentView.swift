//
//  ContentView.swift
//  BlazeWSC
//
//  Created by Javier Etxarri on 21/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stories Row")
            BlazeView() {}
            Text("Audio module")
            AudioTimeLine(audio: .preview)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
