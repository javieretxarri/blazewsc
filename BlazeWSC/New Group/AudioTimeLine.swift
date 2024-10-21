//
//  AudioTimeLine.swift
//
//
//  Created by Nacho on 12/3/24.
//

import SwiftUI

public struct AudioTimeLine: View {
    @StateObject var viewModel: AudioViewModel
    
    public init(
        viewModel: AudioViewModel
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public init(
        audio: AudioDataModel
    ) {
        self.init(viewModel: AudioViewModel(audio: audio))
    }
    
    public var body: some View {
        HStack {
            VStack {
                Button {
                    viewModel.playAudio()
                } label: {
                    SwiftUI.Image(systemName:  viewModel.isAudioPlaying ? "pause" :"play")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30,
                               height: 30,
                               alignment: .center)
                        .padding(.top, Constants.padding10)
                }
                Spacer()
            }
            // MARK: custom slider
            VStack {
                GeometryReader { geometry in
                    ZStack() {
                        HStack(spacing: 0) {
                            if let currentTime = viewModel.currentTime, let totalTime = viewModel.totalTime, totalTime > 0 {
                                ForEach(0..<Constants.rectangleNumbersInt, id: \.self) { index in
                                    let currentTimeProgress = ((currentTime) / (totalTime)) * geometry.size.width - Constants.rectangleCurrentTimeProgress
                                    Rectangle()
                                        .foregroundColor(index * Int(geometry.size.width / Constants.rectangleForeground) <= Int(currentTimeProgress) ? .blue : .red)
                                        .frame(width: geometry.size.width / Constants.rectangleNumbers, height: Constants.rectangleHeight)
                                }
                            }
                        }
                        .mask(
                            SwiftUI.Image("AudioFrame")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width, height: Constants.maskHeight)
                            
                        )
                    }
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let touchLocation = value.location.x
                            let clickTouchLocation = touchLocation / geometry.size.width
                            viewModel.selectedTime = clickTouchLocation * (viewModel.totalTime ?? 0.0)
                        }
                    )
                    
                }
                .onAppear {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewModel.handleTap(_:)))
                    windowScene.windows.first?.addGestureRecognizer(tapGesture)
                    viewModel.statWithDelay()
                }
                Spacer(minLength: Constants.spacerMinLength)
                HStack {if let currentTime = viewModel.currentTime, let totalTime = viewModel.totalTime {
                    Text("\(currentTime.formattedTime)")
                    Spacer()
                    Text("\(totalTime.formattedTime)")
                }
                }
                .padding(.top)
            }
            .frame(maxWidth: .infinity)
        }
    }
    private enum Constants {
        static let spacerMinLength: CGFloat = 35.0
        static let padding10: CGFloat = 10.0
        static let maskHeight: CGFloat = 100.0
        static let rectangleHeight: CGFloat = 50.0
        static let rectangleNumbers: CGFloat = 70.0
        static let rectangleNumbersInt: Int = 70
        static let rectangleCurrentTimeProgress: CGFloat = 15.0
        static let rectangleForeground: CGFloat = 65.0
    }
}
