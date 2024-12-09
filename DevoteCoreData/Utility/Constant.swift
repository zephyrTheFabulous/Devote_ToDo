//
//  Constant.swift
//  DevoteCoreData
//
//  Created by Anthony on 10/11/24.
//

import SwiftUI

  //MARK: - FORMATTER
let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

  //MARK: - UI

var backgroundGradient: LinearGradient {
  return LinearGradient(colors: [.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
}

  //MARK: - UX

let feedback = UINotificationFeedbackGenerator()
