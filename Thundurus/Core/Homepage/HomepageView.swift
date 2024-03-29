import SwiftUI

struct HomepageView: View {
    @State var showWeather: Bool;
    @State var location: String;
    @State var animateGradient = false;
    @State private var progress: CGFloat = 0;
//    private let weatherService:WeatherService = WeatherService();
    
    func fetchLocation(location: String){
        let fullURL: String = "http://localhost:8080/mobilemicroservicestarter/location?postal=" + location;
        
        guard let request = URL(string: fullURL) else {
            return;
        };
        
        let dataTask = URLSession.shared.dataTask(with: request){ data,
            _, error in
            guard let data = data, error == nil else {
                return;
            }
            do{
                let location = try JSONDecoder().decode(Response.self, from: data);
                DispatchQueue.main.async {
                    
                }
            }catch{
                
            }
//            let location = JSONDecoder().decode(AnyClass.self, from: data);
            }

        dataTask.resume();
    }
    var body: some View {
        let firstColor = Color(red: 198/255,green:255/255,blue:221/255);
        let secondColor = Color(red: 251/255,green:215/255,blue:134/255);
        let thirdColor = Color(red: 247/255,green:121/255,blue:125/255);
        let orange = Color(red: 251/255,green:133/255,blue:0);
        let lighterOrange = Color(red: 1,green:214/255,blue:10/255);
        let gradient1 = Gradient(colors: [firstColor, secondColor]);
        let gradient2 = Gradient(colors: [secondColor, thirdColor]);
        
        ZStack{
            Rectangle().animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress).ignoresSafeArea().onAppear {
                withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                    self.progress = 1.0
                }
            }
            
            RoundedRectangle(cornerRadius:25)
                    .frame(maxWidth: 350, maxHeight: .infinity)
                    .padding()
                    .foregroundColor(Color.white)
                    .opacity(0.5)
                    .overlay(
                        Group{
                            LazyVStack(alignment: .center, spacing: 20) {
                                Text("Thundurus").font(.system(size: 48, weight: .light, design: .serif)).foregroundStyle(LinearGradient(colors: [orange, lighterOrange], startPoint: .leading, endPoint: .trailing));
                                Text("A weather app build with ⚡️").font(.system(size: 24, weight: .light, design: .serif)).foregroundColor(.gray);
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                    TextField("Enter a Location", text: $location)
                                }.modifier(customViewModifier(roundedCornes: 25, startColor: .orange, endColor: .purple, textColor: .white)).padding()
                                
                                Button(
                                    action: {
                                        let data = self.fetchLocation(location: location);
                                        var _ = print(data);
                                        
                                    }
                                    ,label: {
                                      Text("Search").padding().foregroundColor(.white).background(Color(red: 141/255, green: 179/255, blue: 139/255)).clipShape(Capsule())});
                                
                                
                            }.padding();
            });
        }
        }
    }

struct customViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var startColor: Color
    var endColor: Color
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.gray.opacity(0.15))
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                        .stroke(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5))
            .font(.custom("Open Sans", size: 18))
            .shadow(radius: 10)
    }
}

//struct HomepageView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomepageView()
//        ThundurusApp()
//    }
//}

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
