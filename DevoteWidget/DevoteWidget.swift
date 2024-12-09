//
//  DevoteWidget.swift
//  DevoteWidget
//
//  Created by Anthony on 13/11/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct DevoteWidgetEntryView : View {
    var entry: Provider.Entry

  @Environment(\.widgetFamily) var widgetFamily

  var fontStyle: Font {
    if widgetFamily == .systemSmall {
      return .system(.footnote, design: .rounded)
    } else {
      return .system(.headline, design: .rounded)
    }
  }

    var body: some View {
        VStack {
//            Text("Time:")
//            Text(entry.date, style: .time)
//
//            Text("Emoji:")
//            Text(entry.emoji)

          GeometryReader { geo in
            ZStack {
              backgroundGradient
              
              Image(.rocketSmall)
                .resizable()
                .scaledToFit()
              Image(.logo)
                .resizable()
                .frame(
                  width: widgetFamily != .systemSmall ? 56 : 36,
                  height: widgetFamily != .systemSmall ? 56 : 36)
                .offset(x: geo.size.width / 2 - 20, y: geo.size.height / -2 + 20)
                .padding(.top, widgetFamily != .systemSmall ? 32 : 12)
                .padding(.trailing, widgetFamily != .systemSmall ? 32 : 12)
              HStack {
                Text("Just Do It")
                  .foregroundStyle(.white)
                  .font(fontStyle)
                  .padding(.horizontal, 12)
                  .padding(.vertical, 4)
                  .background(
                    Color.black.opacity(0.5)
                      .blendMode(.overlay)
                  )
                  .clipShape(Capsule())

                if widgetFamily != .systemSmall { // customization for medium & large
                  Spacer()
                }
              } //: HSTACK
              .padding()
              .offset(y: geo.size.height / 2 - 24)
            } //: ZSTACK
          } //: GEOMETRY
        }
    }
}

struct DevoteWidget: Widget {
    let kind: String = "DevoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                DevoteWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                DevoteWidgetEntryView(entry: entry)
                    .padding()
                    .background(.red)
            }
        }
        .contentMarginsDisabled()
        .configurationDisplayName("Devote Launcher")
        .description("This is an example widget for the personal task manager app.")
    }
}

#Preview(as: .systemSmall) {
    DevoteWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
}
#Preview(as: .systemMedium) {
    DevoteWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
}
#Preview(as: .systemLarge) {
    DevoteWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
}
