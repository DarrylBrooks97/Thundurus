import SwiftUI

struct HomepageView: View {
    @State private var animateGradient = false;
    @State private var progress: CGFloat = 0;
    var body: some View {
        let firstColor = Color(red: 198/255,green:255/255,blue:221/255);
        let secondColor = Color(red: 251/255,green:215/255,blue:134/255);
        let thirdColor = Color(red: 247/255,green:121/255,blue:125/255);
        let gradient1 = Gradient(colors: [firstColor, secondColor]);
        let gradient2 = Gradient(colors: [secondColor, thirdColor]);
        
        ZStack{
            Rectangle().animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress).ignoresSafeArea().onAppear {
                withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                    self.progress = 1.0
                }
            }
            RoundedRectangle(cornerRadius:25).frame(width: 350, height: 300)
                    .padding()
                    .foregroundColor(Color.white.opacity(0.5))
                    .overlay(
                        Group{
                            LazyVStack {
                                Text("Thundurus").font(.system(size: 48, weight: .light, design: .serif)).foregroundColor(.white);
                                Text("A weather app build with ⚡️").font(.system(size: 24, weight: .light, design: .serif)).foregroundColor(.white);
                            }
                        }
                    );
        }
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}

struct AnimatableGradientModifier: AnimatableModifier {
    let fromGradient: Gradient
    let toGradient: Gradient
    var progress: CGFloat = 0.0
 
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
 
    func body(content: Content) -> some View {
        var gradientColors = [Color]()
 
        for i in 0..<fromGradient.stops.count {
            let fromColor = UIColor(fromGradient.stops[i].color)
            let toColor = UIColor(toGradient.stops[i].color)
 
            gradientColors.append(colorMixer(fromColor: fromColor, toColor: toColor, progress: progress))
        }
 
        return LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
 
    func colorMixer(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> Color {
        guard let fromColor = fromColor.cgColor.components else { return Color(fromColor) }
        guard let toColor = toColor.cgColor.components else { return Color(toColor) }
 
        let red = fromColor[0] + (toColor[0] - fromColor[0]) * progress
        let green = fromColor[1] + (toColor[1] - fromColor[1]) * progress
        let blue = fromColor[2] + (toColor[2] - fromColor[2]) * progress
 
        return Color(red: Double(red), green: Double(green), blue: Double(blue))
    }
}

extension View {
    func animatableGradient(fromGradient: Gradient, toGradient: Gradient, progress: CGFloat) -> some View {
            self.modifier(AnimatableGradientModifier(fromGradient: fromGradient, toGradient: toGradient, progress: progress))
        }
}
