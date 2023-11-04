//
//  Mostrar.swift
//  3-ToDoTask
//
//  Created by Yorgi Del Rio on 10/20/23.
//

import SwiftUI

struct AddArticulos: View {
    
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss //Esto se usa para desaparecer vistas
    
    @State private var articulos: String = ""
    
    var body: some View {
        NavigationView {
            Form{
                TextField("Tasks...", text: self.$articulos)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    let agregar = Tasks(context: self.moc) //aqui accedemos a la base de datos
                    agregar.task = self.articulos
                    try! self.moc.save()
                    dismiss() //Esto es para ocultar la vista al darle click al button
                } label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("Add")
                    }
                }.disabled(articulos.isEmpty ? true : false) //si articulos esta vacio el boton esta desabilitado
            }.navigationTitle("Add Tasks")
                
        }
    }
}

struct AddArticulos_Previews: PreviewProvider {
    static var previews: some View {
        AddArticulos()
    }
}
