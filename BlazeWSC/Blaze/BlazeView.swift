import SwiftUI
import BlazeSDK

public struct BlazeView: View {
    @StateObject private var viewModel: BlazeViewModel
    
    public init(
        hideContent: @escaping (() -> Void)
    ) {
        self._viewModel = StateObject(
            wrappedValue: BlazeViewModel(hideContent: hideContent)
        )
    }
    
    public var body: some View {
        ZStack {
            BlazeSwiftUIStoriesRowWidgetView(
                viewModel: viewModel.content
            )
            .frame(height: 150)
        }
        .onAppear {
            viewModel.reloadData()
        }
        .refreshable {
            viewModel.reloadData()
        }
    }
}
