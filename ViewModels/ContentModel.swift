//
//  ContentModel.swift
//  City Sights App
//
//  Created by luane Niejelski on 6/26/22.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    override init() {
        
        // Init method of NSObject
        super.init()
        // Set content model as the delegate of the location manager.
        locationManager.delegate = self
        
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
        // TODO: Start geolocating the user, after we get permission
        //        locationManager.startUpdatingLocation()
    }
    
    //    MARK: - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Update the autho state property
       authorizationState = locationManager.authorizationStatus
        
        if  locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            //    We have permission
            //    ToDo: Start geolocating the user, after we get permission
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied {
            //      We dont have permission
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        
        // Gives us the location of the user
        let userLocation = location.first
        
        if userLocation != nil {
            
            //We have a location
            //Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            //if we have the coordinates of the user send into yelp API
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
        }
    }
    
    // MARK: - Yelp API methods
    func getBusinesses(category: String, location: CLLocation) {
        //    Create URL
        /*
//        let urlString = "https://api.yelp.com/v3/businesses/search"
//        let url = URL
         */
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "categories", value:category),
            URLQueryItem(name: "limit", value: "6")
        ]
        var url = urlComponents?.url
        
        if let url = url {
        //    Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
        //    Get URLSession
            let session = URLSession.shared
            
        //    Create Data task
            let dataTask = session.dataTask(with: request) {
                (data, response, error) in
                
       // Check that there is not an error
        if error == nil {

            do {
//         Parse JSON
          let decoder = JSONDecoder()
          let result = try decoder.decode(
            BusinessSearch.self, from: data!)
                
            DispatchQueue.main.async {
             
//          Assign results to the appropriate property
                if category == Constants.sightsKey {
                    self.sights = result.businesses
                }
                else if category == Constants.restaurantsKey {
                        self.restaurants = result.businesses
                    }
                  }
                }
                catch {
                    print(error)
                }
            }
        }
        //    Start the Data task
            dataTask.resume()
    }
  }
}
