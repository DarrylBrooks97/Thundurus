import SwiftUI

struct HomepageView: View {
    @State private var animateGradient = false;
    var body: some View {
        let firstColor = Color(red: 198/255,green:255/255,blue:221/255);
        let secondColor = Color(red: 251/255,green:215/255,blue:134/255);
        let thirdColor = Color(red: 247/255,green:121/255,blue:125/255);
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [
            firstColor,
            secondColor,
            thirdColor]), startPoint: .topLeading , endPoint: .bottomTrailing).ignoresSafeArea().hueRotation(.degrees(45))

            LazyVStack {
                Text("Thundurus").font(.system(size: 48, weight: .light, design: .serif)).foregroundColor(.white);
                Text("A weather app build with ⚡️").font(.system(size: 24, weight: .light, design: .serif)).foregroundColor(.white);
            }
        }
    }
}
struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
