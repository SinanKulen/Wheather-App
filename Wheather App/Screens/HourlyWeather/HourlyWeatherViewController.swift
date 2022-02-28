//
//  HourlyWeatherViewController.swift
//  Wheather App
//
//  Created by Sinan Kulen on 23.02.2022.
//

import UIKit

class HourlyWeatherViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    
    private var networkService : ClientNetworkServiceProtocol!

    private var latitude : Double?
    private var longitude : Double?
    private var hourlyWeather : HourlyWeatherDTO?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(HourlyWeatherCollectionViewCell.nib ,forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.reuseIdentifier)
        getHourlyWheather()
        
        setGradientLayer()
    }
    
    func setGradientLayer()
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.orange.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: .zero)
    }
    
    func configure(networkService : ClientNetworkServiceProtocol,
                   latitude : Double?,
                   longitude : Double?)
    {
        self.latitude = latitude
        self.longitude = longitude
        self.networkService = networkService
    }
    
    func getHourlyWheather()
    {
        guard let latitude = latitude,
              let longitude = longitude else {
            return
        }
        
        networkService.getHourlyWheather(latitude: latitude, longitude: longitude) {[weak self] (response, error)
            in
            guard let self = self else { return }
            self.hourlyWeather = response
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
          
        }
    }
}

extension HourlyWeatherViewController : UICollectionViewDelegate
{
    
}

extension HourlyWeatherViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = hourlyWeather?.hourly.count ?? 0
        return count > 24 ? 24 : count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.reuseIdentifier, for: indexPath) as! HourlyWeatherCollectionViewCell
        if let item = hourlyWeather?.hourly[indexPath.row]
        {
            cell.configure(with: item)
        }
        return cell
    }
}

extension HourlyWeatherViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 150)
    }
}
