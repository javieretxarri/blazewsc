import SwiftUI
import BlazeSDK

public enum BlazeTheme {
    public enum Row {
        public enum Story {
            public static func circles(titleColor: Color) -> BlazeWidgetLayout {
                var layout = BlazeWidgetLayout.Presets.StoriesWidget.Row.circles
                layout.widgetItemStyle.circle(titleColor: titleColor)
                return layout
            }
        }
    }
    
    public enum Story {
        public static func style() -> BlazeStoryPlayerStyle {
            var style = BlazeStoryPlayerStyle.base()
            style.firstTimeSlide.show = false
            return style
        }
    }
}
