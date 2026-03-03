import SwiftUI

struct ContentView: View {
    @State private var audioApps: [AudioApp] = []
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            ForEach(audioApps.prefix(5), id: \.pid){ app in
                Text(app.name)
            }
        }
        .onAppear{
            audioApps = AudioManager().getRunningAudioApps()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
