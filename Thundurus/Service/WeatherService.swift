import Foundation

struct Location: Hashable, Codable {
    let lat: Double
    let lng: Double
}

struct ViewPort: Hashable, Codable {
    let northEast: Location
    let southWest: Location
}

struct Geometry: Hashable, Codable {
    let location: Location
    let viewPort: ViewPort
}

struct Result: Hashable, Codable {
    let address: String
    let geometry: Geometry
    let icon: String
    let iconBgColor: String
    let iconMaskURI: String
    let name: String
    let placeId: String
    let reference: String
    let types: Array<String>
}

struct Response: Hashable, Codable {
    let html_attributions: Array<String>
    let results: Array<Result>
    let status: String
    
}


struct WeatherService {
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
}
