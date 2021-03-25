//
//  POVIC-Location.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/22.
//


extension POIVC{
    func requestLocation(){
        showLoadHUD()
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
             //print (reGeocode == nil)
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    print("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    self?.hideLoadHUD()
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    print("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                    self?.hideLoadHUD()
                    return 
                }else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            guard let POIVC = self else {return }
            
            if let location = location {
                //print("location:", location)
                POIVC.latitude =  location.coordinate.latitude
                POIVC.longitude = location.coordinate.longitude
                
                //检索周边poi
                POIVC.footer.setRefreshingTarget(POIVC, refreshingAction: #selector(POIVC.aroundSearchPullToRefresh))
                POIVC.makeAroundSearch()
            }
            
            if let reGeocode = reGeocode {
                //print("reGeocode:", reGeocode)

                guard let formattedAddress = reGeocode.formattedAddress ,!formattedAddress.isEmpty else { return }
                
                //判断是否是直辖市
                let province = reGeocode.province == reGeocode.city ? "" : reGeocode.province.unwrappedText
                let currentPOI = [
                    reGeocode.poiName ?? kNoPOIPH,
                    "\(province)\(reGeocode.city.unwrappedText)\(reGeocode.district.unwrappedText)\(reGeocode.street.unwrappedText )\(reGeocode.number .unwrappedText)"
                ]
                POIVC.pois.append(currentPOI)
                POIVC.aroundSearchPOIs.append(currentPOI)
                
//                print("\(province)\(reGeocode.city!)\(reGeocode.district!)\(reGeocode.street ?? "")\(reGeocode.number ?? "")")
                
                DispatchQueue.main.async {
                    POIVC.tableview.reloadData()
                }
            }
        })
    }
}


extension POIVC{
    private func makeAroundSearch(_ page: Int = 1 ){
        aroundSearchRequest.page = page
        mapSearch?.aMapPOIAroundSearch(aroundSearchRequest)
    }
}

extension POIVC{
    @objc private func aroundSearchPullToRefresh() {
        currentAroundPage += 1
        makeAroundSearch(currentAroundPage)
        if currentAroundPage < pageCount{
            footer.endRefreshing()
        }else{
            footer.endRefreshingWithNoMoreData()  //不会有更多请求了 不再监听
        }
    }
}
