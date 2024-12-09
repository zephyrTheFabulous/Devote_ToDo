  //
  //  ContentView.swift
  //  DevoteCoreData
  //
  //  Created by Anthony on 10/11/24.
  //

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - PROPERTY

  @AppStorage("isDarkMode") private var isDarkMode: Bool = false // default mode is Light mode
  @State var task: String = "" // to hold the value that user enters
  @State private var showNewTaskItem: Bool = false


    //MARK: - FETCHING DATA
  @Environment(\.managedObjectContext) private var viewContext // access to storage

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default)
  private var items: FetchedResults<Item>


    //MARK: - FUNCTIONS

  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)

      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }

    //MARK: - BODY
  var body: some View {
    NavigationView {
      ZStack {
          //MARK: - MAIN VIEW
        VStack {
            //MARK: - CUSTOM HEADER FOR NAV BAR
          HStack(alignment: .center, spacing: 10) {
              // TITLE
            Text("Devote")
              .font(.system(.largeTitle, design: .rounded, weight: .heavy))
              .padding(.leading, 4)

            Spacer()

              // EDIT BUTTON
            EditButton()
              .font(.system(size: 16, weight: .semibold, design: .rounded))
              .padding(.horizontal, 10)
              .frame(minWidth: 70, minHeight: 24)
              .background(Capsule().stroke(.white, lineWidth: 2))

              // APPEARANCE BUTTON
            Button {
              isDarkMode.toggle()
              playSound(sound: "sound-tap", type: "mp3")
              feedback.notificationOccurred(.success)
            } label: {
              Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                .resizable()
                .font(.system(.title, design: .rounded))
                .frame(width: 24, height: 24)
            }


          } //: CUSTOM HEADER FOR NAV BAR
          .padding()
          .foregroundStyle(.white)

          Spacer(minLength: 80)

            //MARK: - NEW TASK BUTTON

          Button {
            showNewTaskItem = true
            playSound(sound: "sound-ding", type: "mp3")
            feedback.notificationOccurred(.success)
          } label: {
            Image(systemName: "plus.circle")
              .font(.system(size: 30, weight: .semibold, design: .rounded))
            Text("New Task")
              .font(.system(size: 24, weight: .bold, design: .rounded))
          }
          .foregroundStyle(.white)
          .padding(.horizontal, 20)
          .padding(.vertical, 15)
          .background(
            .linearGradient(colors: [.pink, .blue], startPoint: .leading, endPoint: .trailing)
          )
          .clipShape(Capsule())
          .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4)


            //MARK: - TASKS
          List {
            ForEach(items) { item in
              ListRowItemView(item: item)
              
              // old code
//              VStack (alignment: .leading) {
//                Text(item.task ?? "")
//                  .font(.headline)
//                  .fontWeight(.bold)
//                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                  .font(.footnote)
//                  .foregroundStyle(.gray)
//              } 
            } //: LIST
            .onDelete(perform: deleteItems)
          } //: LIST
          .listStyle(.insetGrouped)
          .shadow(color: .black.opacity(0.3), radius: 12)
          .padding(.vertical, 0)
          .frame(maxWidth: 640) // for iPad
        } //: VSTACK
        .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false) // Blur is active only when showNewTaskItem is active
        .transition(.move(edge: .bottom)) // no effect?
        .animation(.easeOut(duration: 0.5), value: showNewTaskItem)

          //MARK: - NEW TASK ITEM
        if showNewTaskItem {
          BlankView( //
            backgroundColor: isDarkMode ? .black : .gray,
            backgroundOpacity: isDarkMode ? 0.3 : 0.5)
            .onTapGesture {
              withAnimation() {
                showNewTaskItem = false
              }
            }
          NewTaskItemView(isShowing: $showNewTaskItem)
        }

      } //: ZSTACK
      .scrollContentBackground(.hidden)
      .toolbar(.hidden) // put in front of .navigationTitle
      .navigationTitle("Daily Tasks")
      .navigationBarTitleDisplayMode(.large)
        //      .toolbar { // no need because of new custom header
        //        ToolbarItem(placement: .navigationBarTrailing) {
        //          EditButton()
        //        }
        //          //        ToolbarItem {
        //          //          Button(action: addItem) {
        //          //            Label("Add Item", systemImage: "plus")
        //          //          }
        //          //        }
        //      } //: TOOLBAR
      .background(BackgroundImageView()
      .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
      )
      .background(backgroundGradient.ignoresSafeArea())
    } //: NAVIGATION
  }


}



#Preview {
  ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
