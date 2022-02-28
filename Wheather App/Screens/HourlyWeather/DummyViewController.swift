//
//  DummyViewController.swift
//  Wheather App
//
//  Created by Sinan Kulen on 25.02.2022.
//

import UIKit

class DummyViewController: UIViewController {

    private var networkService : ClientNetworkServiceProtocol = ClientNetworkService()
    private var hourlyWeather : HourlyWeatherDTO?
    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.getHourlyWheather(latitude: 49.2, longitude: 29.0) {(response, error)
            in
//            guard let self = self else { return }
            self.hourlyWeather = response
         
        }
    }
    
    deinit {
        print(DummyViewController.nibName)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
