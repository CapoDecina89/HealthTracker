//
//  ChallengeRing.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 18.01.23.
//

import SwiftUI

/// Nested activity rings
struct ChallengeRing: View {
    var challengeProgress: Double
    
    var body: some View {
        
        GeometryReader { geo in
            Ring(progress: challengeProgress,
                lineWidth: geo.size.width/10,
                gradient: .activityProgress)
            .padding()
        }
    }
}


/// Base activity ring
struct Ring: View {
    var progress: Double
    var lineWidth: CGFloat
    var gradient: Gradient
    
    var body: some View {
        ZStack {
            Text("\(Int(progress*100))%")
                .font(.title)
                .bold()
                .padding()
            // Background ring
            Circle()
                .stroke(
                    gradient.stops.last!.color,
                    style: .init(lineWidth: lineWidth)
                )
                .opacity(0.1)
            // Main ring
            Circle()
                .rotation(.degrees(-90))
                .trim(from: 0, to: CGFloat(progress))
                .stroke(
                    angularGradient(),
                    style: .init(lineWidth: lineWidth, lineCap: .round)
                )
                .overlay(
                    GeometryReader { geometry in
                        // End round butt and shadow
                        Circle()
                            .fill(endButtColor())
                            .frame(width: self.lineWidth, height: self.lineWidth)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            .offset(x: min(geometry.size.width, geometry.size.height)/2)
                            .rotationEffect(.degrees(self.progress * 360 - 90))
                            .shadow(color: .black, radius: self.lineWidth/4, x: 0, y: 0)
                    }
                    .clipShape(
                        // Clip end round line cap and shadow to front
                        Circle()
                            .rotation(.degrees(-90 + self.progress * 360 - 0.5))
                            .trim(from: 0, to: 0.25)
                            .stroke(style: .init(lineWidth: self.lineWidth))
                    )
                )
        }
        //.scaledToFit()
        .padding(lineWidth/2)
    }
    
    func angularGradient() -> AngularGradient {
        return AngularGradient(gradient: gradient, center: .center, startAngle: .degrees(-90), endAngle: .degrees((progress > 0.5 ? progress : 0.5) * 360 - 90))
    }
    
    func endButtColor() -> Color {
        let color = progress > 0.5 ? gradient.stops.last!.color : gradient.stops.first!.color.interpolateTo(color: gradient.stops.last!.color, fraction: 2 * progress)
        return color
    }
}


/// Activity app gradient colors
extension Gradient {
    static var activityProgress: Gradient {
        return Gradient(colors: [
            Color(red: 0, green: 0.7294117647, blue: 0.8823529412),
            Color(red: 0, green: 0.9803921569, blue: 0.8156862745)
        ])
    }
}


/// SwiftUI color interpolation
extension Color {
    var components: (r: Double, g: Double, b: Double, o: Double)? {
        let uiColor: UIColor
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0
        
        if self.description.contains("NamedColor") {
            let lowerBound = self.description.range(of: "name: \"")!.upperBound
            let upperBound = self.description.range(of: "\", bundle")!.lowerBound
            let assetsName = String(self.description[lowerBound..<upperBound])
            
            uiColor = UIColor(named: assetsName)!
        } else {
            uiColor = UIColor(self)
        }

        guard uiColor.getRed(&r, green: &g, blue: &b, alpha: &o) else { return nil }
        
        return (Double(r), Double(g), Double(b), Double(o))
    }
    
    func interpolateTo(color: Color, fraction: Double) -> Color {
        let s = self.components!
        let t = color.components!
        
        let r: Double = s.r + (t.r - s.r) * fraction
        let g: Double = s.g + (t.g - s.g) * fraction
        let b: Double = s.b + (t.b - s.b) * fraction
        let o: Double = s.o + (t.o - s.o) * fraction
        
        return Color(red: r, green: g, blue: b, opacity: o)
    }
}

struct ChallengeRing_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeRing(challengeProgress: challenges[0].progress)
    }
}
