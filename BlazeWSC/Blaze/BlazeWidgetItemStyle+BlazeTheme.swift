import SwiftUI
import BlazeSDK

extension BlazeWidgetItemStyle {
	mutating func circle(titleColor: Color) {
        self.title.isVisible = true
        self.title.position.xPosition = .centerX(offset: 0.0)
        self.title.position.yPosition = .topToBottom(offset: 10.0)
        self.title.insets = .init(EdgeInsets(top: 0.0, leading: 4.0, bottom: 0.0, trailing: 4.0))
        
        self.title.unreadState.font = .systemFont(ofSize: .zero, weight: .bold)
        self.title.unreadState.letterSpacing = .zero
        self.title.unreadState.textColor = UIColor(titleColor)
        self.title.unreadState.lineHeight = 16
        self.title.unreadState.numberOfLines = 2
        self.title.unreadState.alignment = .center
        
        self.title.readState.font = .systemFont(ofSize: .zero, weight: .bold)
        self.title.readState.letterSpacing = .zero
        self.title.readState.textColor = UIColor(titleColor)
        self.title.readState.lineHeight = 16
        self.title.readState.numberOfLines = 2
        self.title.readState.alignment = .center
	}
}
