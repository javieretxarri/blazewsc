import SwiftUI
import BlazeSDK

public final class BlazeViewModel: ObservableObject {
    
    @Published var content: BlazeSwiftUIStoriesWidgetViewModel!
    var hideContent: (() -> Void)
    
    init(
        hideContent: @escaping (() -> Void)
    ) {
        self.hideContent = hideContent
        setupContent()
    }
    
    private func setupContent() {
        self.content =  BlazeSwiftUIStoriesWidgetViewModel(
            widgetConfiguration: BlazeSwiftUIWidgetConfiguration(
                layout: BlazeTheme.Row.Story.circles(
                    titleColor: .black
                ),
                dataSourceType: .labels(
                    .mustInclude("highlights")
                )
            ),
            storyPlayerStyle: BlazeTheme.Story.style(),
            delegate: delegate
        )
        
    }
    
    func reloadData(progressType: BlazeProgressType = .skeleton) {
        content.reloadData(progressType: progressType)
    }
}

extension BlazeViewModel {
    private var delegate: BlazeWidgetDelegate {
        .init(
            onDataLoadComplete: { params in
                if params.itemsCount == 0 {
                    self.hideContent()
                }
            }
        )
    }
}
