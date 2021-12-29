import SwiftUI

struct ContentView: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 70.0

    @State private var amount = 1.0
    @State private var lineWidth = 1.5

    @State private var distance = 25.0
    @State private var distanceIncrementing = false
    @State private var animateDistance = true
    @State private var animateDistanceSpeed = 0.5
    @State private var minimumDistance = 1.0

    @State private var rotation = 0.0
    @State private var animateRotation = true
    @State private var rotationAmount = 0.2

    @State private var showingOptions = false

    @State private var hue = 0.0
    @State private var hueIncrementing = true
    @State private var animateHue = false

    @State private var color = Color.white

    @State private var scale = 1.0

    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    private var graphColor: Color {
        animateHue ? Color(hue: hue, saturation: 1, brightness: 1) : color
    }
    
    private func setDefault() {
        innerRadius = 125.0
        outerRadius = 70.0
        
        amount = 1.0
        lineWidth = 1.5
        
        distance = 25.0
        distanceIncrementing = false
        animateDistance = true
        animateDistanceSpeed = 0.5
        minimumDistance = 1.0
        
        rotation = 0.0
        animateRotation = true
        rotationAmount = 0.2
        
        showingOptions = false
        
        hue = 0.0
        hueIncrementing = true
        animateHue = false
        
        color = Color.white
        
        scale = 1.0
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
                Spacer()
                if showingOptions {
                    ScrollView {
                        VStack {
                            Group {
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
                                .padding(.bottom)
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
                                } else {
                                    VStack {
                                        HStack {
                                            Text("Distance Animation Amount")
                                            Spacer()
                                            Text("\(animateDistanceSpeed, format: .number.precision(.fractionLength(1)))")
                                        }
                                        .font(.body.bold())
                                        Slider(value: $animateDistanceSpeed, in: 0.2...5.0, step: 0.1)
                                    }
                                    .paddedStack()
                                    VStack {
                                        HStack {
                                            Text("Distance Animation Minimum Value")
                                            Spacer()
                                            Text("\(Int(minimumDistance))")
                                        }
                                        .font(.body.bold())
                                        Slider(value: $minimumDistance, in: 1...149, step: 1)
                                    }
                                    .paddedStack()
                                }
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
                            .padding(.vertical)
                            VStack {
                                Toggle("Animate Rotation", isOn: $animateRotation.animation())
                                    .tint(.init(white: 0.75))
                                .font(.body.bold())
                            }
                            .paddedStack()
                            if animateRotation {
                                VStack {
                                    HStack {
                                        Text("Rotation Amount")
                                        Spacer()
                                        Text("\(rotationAmount, format: .number.precision(.fractionLength(2)))")
                                    }
                                    .font(.body.bold())
                                    Slider(value: $rotationAmount, in: -2.5...2.5, step: 0.01)
                                }
                                .paddedStack()
                            }
                            VStack {
                                Toggle("Animate Color", isOn: $animateHue.animation())
                                    .tint(.init(white: 0.75))
                                .font(.body.bold())
                            }
                            .paddedStack()
                            .padding(.top)
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
                            .padding(.top)
                        }
                        .padding(.top)
                    }
                }
                HStack {
                    Menu {
                        Button {
                            withAnimation {
                                setDefault()
                            }
                        } label: {
                            Text("Simple Spirograph")
                        }
                    } label: {
                        ZStack {
                            Image(systemName: "seal")
                                .foregroundColor(showingOptions ? .white : .white.opacity(0))
                                .scaleEffect(showingOptions ? 1 : 0.1)
                                .offset(x: showingOptions ? 0 : 50, y: 0)
                                .animation(Animation.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1).delay(showingOptions ? 0.1 : 0), value: showingOptions)
                        }
                        .font(.title.bold())
                        .padding()
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
                        .padding()
                    }
                    Button {
                        if let url = URL(string: "https://www.hackingwithswift.com/books/ios-swiftui/creating-a-spirograph-with-swiftui"),
                           UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:])
                        }
                    } label: {
                        ZStack {
                            Image(systemName: "chevron.left.forwardslash.chevron.right")
                                .foregroundColor(showingOptions ? .white : .white.opacity(0))
                                .scaleEffect(showingOptions ? 1 : 0.1)
                                .offset(x: showingOptions ? 0 : -50, y: 0)
                                .animation(Animation.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1).delay(showingOptions ? 0.2 : 0), value: showingOptions)
                        }
                        .font(.title.bold())
                        .padding()
                    }
                }
            }
        }
        .background(Color.black)
        .onAppear {
            animateRotation = true
        }
        .onTapGesture {
            withAnimation {
                showingOptions = true
            }
        }
        .onReceive(timer) { _ in
            if animateDistance {
                if distanceIncrementing {
                    distance += animateDistanceSpeed
                    if distance > 150 {
                        distance = 150
                        distanceIncrementing = false
                    }
                } else {
                    distance -= animateDistanceSpeed
                    if distance < minimumDistance {
                        distance = minimumDistance
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
                rotation += rotationAmount
                if rotation > 360 {
                    rotation = 0
                } else if rotation < -360 {
                    rotation = 0
                }
            }
        }
    }
}
