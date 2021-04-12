//
//  POIVC-Config.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/22.
//


extension POIVC{
    func config(){
        
        //定位
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 5
        locationManager.reGeocodeTimeout = 5
        
        mapSearch?.delegate = self

        tableview.mj_footer = footer
        
        if let cancelButton =  searchBar.value(forKey: "cancelButton") as? UIButton{
            cancelButton.isEnabled = true
        }
    }
}
