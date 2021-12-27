import SwiftUI

struct ContentView: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 70.0

    @State private var amount = 1.0
    @State private var lineWidth = 2.0

    @State private var distance = 25.0
    @State private var distanceIncrementing = false
    @State private var animateDistance = true

    @State private var rotation = 0.0
    @State private var animateRotation = true

    @State private var showingOptions = true

    @State private var hue = 0.0
    @State private var hueIncrementing = true
    @State private var animateHue = false

    @State private var color = Color.white

    @State private var scale = 1.0

    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    var graphColor: Color {
        animateHue ? Color(hue: hue, saturation: 1, brightness: 1) : color
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                ZStack {
                    Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                        .stroke(graphColor, lineWidth: lineWidth)
                        .blur(radius: 3)

                    Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                        .stroke(graphColor, lineWidth: lineWidth)
                }
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotation))
            }
            VStack {
                if showingOptions {
                    ScrollView {
                        VStack {
                            VStack {
                                HStack {
                                    Text("Inner Radius")
                                    Spacer()
                                    Text("\(Int(innerRadius))")
                                }
                                .font(.body.bold())
                                Slider(value: $innerRadius, in: 1...150, step: 1)
                            }
                            .paddedStack()
                            VStack {
                                HStack {
                                    Text("Outer Radius")
                                    Spacer()
                                    Text("\(Int(outerRadius))")
                                }
                                .font(.body.bold())
                                Slider(value: $outerRadius, in: 1...150, step: 1)
                            }
                            .paddedStack()
                            VStack {
                                Toggle("Animate Distance", isOn: $animateDistance.animation())
                                    .tint(.init(white: 0.75))
                                .font(.body.bold())
                            }
                            .paddedStack()
                            if !animateDistance {
                                VStack {
                                    HStack {
                                        Text("Distance")
                                        Spacer()
                                        Text("\(Int(distance))")
                                    }
                                    .font(.body.bold())
                                    Slider(value: $distance, in: 1...150, step: 1)
                                }
                                .paddedStack()
                            }
                            VStack {
                                HStack {
                                    Text("Line Width")
                                    Spacer()
                                    Text("\(lineWidth, format: .number.precision(.fractionLength(1)))")
                                }
                                .font(.body.bold())
                                Slider(value: $lineWidth, in: 0.1...10, step: 0.1)
                            }
                            .paddedStack()
                            VStack {
                                Toggle("Animate Rotation", isOn: $animateRotation.animation())
                                    .tint(.init(white: 0.75))
                                .font(.body.bold())
                            }
                            .paddedStack()
                            VStack {
                                Toggle("Animate Color", isOn: $animateHue.animation())
                                    .tint(.init(white: 0.75))
                                .font(.body.bold())
                            }
                            .paddedStack()
                            if !animateHue {
                                VStack {
                                    ColorPicker("Color", selection: $color)
                                        .font(Font.body.bold())
                                }
                                .paddedStack()
                            }
                            VStack {
                                HStack {
                                    Text("Scale")
                                    Spacer()
                                    Text("\(scale, format: .number.precision(.fractionLength(1)))")
                                }
                                .font(.body.bold())
                                Slider(value: $scale, in: 0.1...5, step: 0.1)
                            }
                            .paddedStack()
                        }
                        .padding(.vertical)
                    }
                } else {
                    Spacer()
                }
                Button {
                    withAnimation {
                        showingOptions.toggle()
                    }
                } label: {
                    ZStack {
                        Image(systemName: "chevron.up")
                            .foregroundColor(showingOptions ? .white.opacity(0) : .white.opacity(0.25))
                            .offset(x: 0, y: showingOptions ? -50 : 0)
                            .animation(showingOptions ? .easeOut :
                                       Animation.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1), value: showingOptions)
                        Image(systemName: "xmark")
                            .foregroundColor(showingOptions ? .white : .white.opacity(0))
                            .rotationEffect(.degrees(showingOptions ? 0 : 180))
                            .scaleEffect(showingOptions ? 1 : 0.1)
                            .animation(Animation.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1), value: showingOptions)
                    }
                    .font(.title.bold())
                }
            }
        }
        .background(Color.black)
        .onAppear {
            animateRotation = true
        }
        .onReceive(timer) { _ in
            if animateDistance {
                if distanceIncrementing {
                    distance += 0.5
                    if distance > 150 {
                        distance = 150
                        distanceIncrementing = false
                    }
                } else {
                    distance -= 0.5
                    if distance < 1 {
                        distance = 1
                        distanceIncrementing = true
                    }
                }
            }

            if animateHue {
                if hueIncrementing {
                    hue += 0.001
                    if hue > 1 {
                        hue = 1
                        hueIncrementing = false
                    }
                } else {
                    hue -= 0.001
                    if hue < 0 {
                        hue = 0
                        hueIncrementing = true
                    }
                }
            }

            if animateRotation {
                rotation += 0.2
                if rotation > 360 {
                    rotation = 0
                }
            }
        }
    }
}
