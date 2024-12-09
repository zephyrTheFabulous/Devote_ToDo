//
//  NewTaskItemView.swift
//  DevoteCoreData
//
//  Created by Anthony on 11/11/24.
//

import SwiftUI

struct NewTaskItemView: View {
    //MARK: - PROPERTIES

  @AppStorage("isDarkMode") private var isDarkMode: Bool = false
  @Environment(\.managedObjectContext) private var viewContext
  @State var task: String = "" // to hold the value that user enters
  @FocusState private var taskIsFocused: Bool // cursor goes right into TextField
  @Binding var isShowing: Bool

  private var isButtonDisabled: Bool { // comp.property to check if the TextField is empty
    task.isEmpty
  }

    //MARK: - FUNCTIONS

  private func addItem() {
    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()
      newItem.task = task
      newItem.completion = false
      newItem.id = UUID()
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }

      task = ""
      hideKeyboard()
      isShowing = false
    }
  }

    //MARK: - BODY
    var body: some View {
      VStack {
        Spacer()
        
        VStack(spacing: 16) {
          TextField("New Task", text: $task)
            .focused($taskIsFocused)
            .onSubmit {
              if !isButtonDisabled {
                addItem()
              }
            }
            .foregroundStyle(.pink)
            .font(.system(size: 24, weight: .bold, design: .rounded))
            .padding()
            .background(
              isDarkMode ? Color(.tertiarySystemBackground) : Color(.secondarySystemBackground)
            )
            .clipShape(.rect(cornerRadius: 10))

          Button {
            addItem()
            playSound(sound: "sound-ding", type: "mp3")
            feedback.notificationOccurred(.success)
          } label: {
            Spacer()
            Text("SAVE")
              .font(.system(size: 24, weight: .bold, design: .rounded))
            Spacer()
          }
          .disabled(isButtonDisabled)
          .onTapGesture {
            if isButtonDisabled {
              playSound(sound: "sound-tap", type: "mp3")
            }
          }
          .padding()
          .foregroundStyle(.white)
          .background(isButtonDisabled ? .blue : .pink)
          .clipShape(.rect(cornerRadius: 10))
        } //: VSTACK
        .padding(.horizontal)
        .padding(.vertical, 20)
        .background(
          isDarkMode ? Color(.secondarySystemBackground) : Color(.white)
        )
        .clipShape(.rect(cornerRadius: 16))
        .shadow(color: .black.opacity(0.65), radius: 24)
        .frame(maxWidth: 640)
      } //: VSTACK
      .padding()
      .onAppear() {
        taskIsFocused = true
      }
    }
}

#Preview {
  NewTaskItemView(isShowing: .constant(true))
    .background(Color.gray.ignoresSafeArea())
}
