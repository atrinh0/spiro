import SwiftUI

struct ContentView: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount = 1.0
    @State private var hue = 0.0
    @State private var lineWidth = 2.0
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            ZStack {
                Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                    .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: lineWidth)
                    .blur(radius: 3)
                
                Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                    .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: lineWidth)
            }
            .rotationEffect(.degrees(animate ? 0 : 360))
            .animation(.linear(duration: 60).repeatForever(autoreverses: false), value: animate)
            .frame(width: 300, height: 300)
            .onAppear {
                animate = true
            }
            
            Spacer()
            
            Group {
                Group {
                    Text("Inner radius: \(Int(innerRadius))")
                    Slider(value: $innerRadius, in: 10...150, step: 1)
                        .padding([.horizontal, .bottom])
                
                    Text("Outer radius: \(Int(outerRadius))")
                    Slider(value: $outerRadius, in: 10...150, step: 1)
                        .padding([.horizontal, .bottom])
                    
                    Text("Distance: \(Int(distance))")
                    Slider(value: $distance, in: 1...150, step: 1)
                        .padding([.horizontal, .bottom])
                }
                Text("Line width: \(lineWidth, format: .number.precision(.fractionLength(2)))")
                Slider(value: $lineWidth, in: 0.1...10, step: 0.1)
                    .padding([.horizontal, .bottom])
                
                Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])
                
                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
            }
        }
        .background(Color.black)
    }
}
