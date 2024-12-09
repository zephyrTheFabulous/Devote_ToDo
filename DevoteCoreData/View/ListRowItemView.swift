//
//  ListRowItemView.swift
//  DevoteCoreData
//
//  Created by Anthony on 11/11/24.
//

import SwiftUI

struct ListRowItemView: View {
    //MARK: - PROPERTIES

  @Environment(\.managedObjectContext) var viewContext
  @ObservedObject var item: Item

    //MARK: - BODY
    var body: some View {
      Toggle(isOn: $item.completion) {
        Text(item.task ?? "")
          .font(.system(.title2, design: .rounded, weight: .heavy))
          .foregroundStyle(item.completion ? .pink : .primary)
          .padding(.vertical, 12)
          .animation(.default, value: item.completion)
      } //: TOGGLE // when the toggle is on it means the task is done and text color changes from system to pink. The text label shows the task itself
      .toggleStyle(CheckboxStyle())
      .onReceive(item.objectWillChange) { _ in
        if viewContext.hasChanges {
          try? viewContext.save()
        }
      } // when there is a change in item.objectWillChange(it's a Publisher), action in body runs(update action)
    }
}

//#Preview {
//    ListRowItemView()
//}
