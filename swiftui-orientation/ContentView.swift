import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        Text("Orientation is \(model.orientationText)")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Model())
    }
}
