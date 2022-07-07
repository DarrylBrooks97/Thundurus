
import SwiftUI

@main
struct ThundurusApp: App {
    @State private var showWeather:Bool = false;
    @State private var location:String = "";
    
    var body: some Scene {
        WindowGroup {
            if(!showWeather){
                HomepageView(showWeather: $showWeather, location: $location)
            }else{
                ContentView();
            }
        }
    }
}
