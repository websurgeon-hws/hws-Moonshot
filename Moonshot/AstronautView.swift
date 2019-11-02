//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width:geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1) // to fix SwiftUI bug causing text to be truncated for some astronauts on some devices
                }
            }
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronaughts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronaughts[0])
    }
}
