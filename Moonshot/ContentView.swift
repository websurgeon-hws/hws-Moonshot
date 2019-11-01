//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            Image("earth-rising")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
