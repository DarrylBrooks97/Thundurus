
import SwiftUI

@main
struct ThundurusApp: App {
    @State var showWeather = false;
    @State var location = "";
//    @StateObject var HomePage = HomepageView();
    
    var body: some Scene {
        WindowGroup {
            HomepageView(showWeather: showWeather, location: location);
//            if(!showWeather){
//                HomepageView(showWeather: $showWeather, location: $location)
//            }else{
//                ContentView();
//            }
        }
    }
}
