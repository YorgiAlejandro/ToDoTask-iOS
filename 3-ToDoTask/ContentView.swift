//
//  ContentView.swift
//  3-ToDoTask
//
//  Created by Yorgi Del Rio on 10/20/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.task, ascending: true),NSSortDescriptor(keyPath: \Tasks.done, ascending: true)],
        animation: .default)
    
    private var tasks: FetchedResults<Tasks>

    @State var mostrar: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    HStack {
                        Button {
                            task.done.toggle() //Aqui alternamos el true o false
                            try! self.moc.save()  //Aqui guardamos la info en la vase de datos cada vez que hay un cambio
                        } label: {
                            Image(systemName: task.done ? "checkmark.rectangle.fill" : "checkmark.rectangle")
                                .font(.headline.bold())
                                .foregroundColor(task.done ? .green : .red)
                        }
                        VStack(alignment: .leading) {
                            Text(task.task ?? "")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.primary)
                                .strikethrough(task.done ? true: false) //Esto es para sobrerayar el texto
                        }
                        Spacer()
                        Text(task.done ? "Listo" : "Pendiente")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: deleteTasks)
            }
            .navigationBarTitle("Tasks To Do")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.mostrar.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Slice task for delete").font(.footnote).opacity(0.6)
                    }
                }.sheet(isPresented: self.$mostrar) {
                    AddArticulos().environment(\.managedObjectContext, self.moc )
                }
        }
    }
    private func deleteTasks(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(moc.delete)

            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
