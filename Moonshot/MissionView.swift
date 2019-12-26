//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        _ = mission
        return GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { imageGeo in
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageGeo.size.width, height: imageGeo.size.height)
                            .padding(.top)
                            .scaleEffect(
                                self.missionImageScaleEffect(
                                    imageGeo.frame(in: .global),
                                    geometry.frame(in: .global))
                            )
                            .accessibility(hidden: true)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.33)

                    HStack {
                        if self.mission.launchDate != nil {
                            Text("Launch Date:")
                            Text("\(self.mission.formattedLaunchDate)")
                        }
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text("Launch Date,  \(self.mission.formattedLaunchDate)"))

                    Text(self.mission.description)
                        .padding()

                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule()  .stroke(Color.primary, lineWidth: 1))
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)

                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle()) // prevent NavigationLink from coloring image and name with tint colour
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName),
                            displayMode: .inline)
    }
    
    func missionImageScaleEffect(_ geoRect: CGRect,
                                 _ fullRect: CGRect) -> CGFloat {
        let scale = geoRect.midY / fullRect.midY * 2

        return min(max(scale, 0.8), 1)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions.first!,
                    astronauts: astronauts)
    }
}

