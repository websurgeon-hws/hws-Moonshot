//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State var showLaunchDate: Bool = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination:
                    MissionView(mission: mission,
                                astronauts: self.astronauts)
                ) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        
                        if self.showLaunchDate {
                            Text(mission.formattedLaunchDate)
                        } else {
                            Text("\(self.crewForMission(mission))")
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showLaunchDate.toggle()
                }) {
                    Text(showLaunchDate ? "Show Crew" : "Shown Launch Date")
                }
            )
        }
    }
    
    func crewForMission(_ mission: Mission) -> String {
        return mission.crew.map { $0.name }.joined(separator: ", ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
