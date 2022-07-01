import Foundation

struct WeatherService {
    func fetchWeatherData(location: String){
        let headers = [
            "X-RapidAPI-Key": "33d18962abmsh493b6461ef0c7c8p10c31ejsn00fa53c6105f",
            "X-RapidAPI-Host": "community-open-weather-map.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://community-open-weather-map.p.rapidapi.com/weather?q=\(location)&lat=0&lon=0&callback=test&lang=null&units=imperial")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0);
        request.httpMethod = "GET";
        request.allHTTPHeaderFields = headers;

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                let _ = print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                let _ = print(httpResponse as Any)
            }
        })

        dataTask.resume()
    }
}
