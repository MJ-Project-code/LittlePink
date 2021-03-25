//
//  POIVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/19.
//

import UIKit

class POIVC: UIViewController, AMapLocationManagerDelegate {

    let locationManager = AMapLocationManager()
    lazy  var mapSearch = AMapSearchAPI()
    lazy  var aroundSearchRequest:AMapPOIAroundSearchRequest = {
        let request = AMapPOIAroundSearchRequest()
                
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(latitude), longitude: CGFloat(longitude))
        //request.types = kPOITypes
        request.requireExtension = true
        request.offset = kPOIsOffset
        return request
    }()
    
    lazy var keywordsSearchRequest:AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.requireExtension = true
        request.keywords = keywords
        request.offset = kPOIsOffset
        return request
    }()

    lazy var footer = MJRefreshAutoNormalFooter()
    
    var pois = kPOIsInitArr
    var aroundSearchPOIs = kPOIsInitArr //完全同步周边poi数组,撤销输入后返回周边poi 
    var latitude = 0.0
    var longitude = 0.0
    var keywords = ""
    var currentAroundPage = 1
    var pageCount = 1
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        requestLocation()
        
        mapSearch?.delegate = self
    }
    
}

extension POIVC:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {dismiss(animated: true)}
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            pois = aroundSearchPOIs
            tableview.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //print(searchBar.text)
        guard let searchText = searchBar.text ,!searchText.isBlank else{ return }
                keywords = searchText
                pois.removeAll()
                showLoadHUD()
                keywordsSearchRequest.keywords = keywords
                mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
    }
}


//所有搜索api的回调
extension POIVC : AMapSearchDelegate{
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        let poiCount = response.count
        hideLoadHUD()
        if poiCount == 0 {
            return
        }
        
        for poi in response.pois{
            //            poi.name
            let province =  poi.province == poi.city ? "" : poi.province
            //偏远地区
            let address = poi.district == poi.address ? "" : poi.address
            
            let poi = [
                poi.name ?? kNoPOIPH,
                "\(province.unwrappedText)\(poi.city.unwrappedText)\(poi.district.unwrappedText)\(address.unwrappedText)"]
            
            pois.append(poi)
            if request is AMapPOIAroundSearchRequest{
                aroundSearchPOIs.append(poi)
            }
        }
        if poiCount > kPOIsOffset{
            pageCount = response.count / kPOIsOffset + 1
        }else{
            footer.endRefreshingWithNoMoreData()
        }
        
        tableview.reloadData()
    }
}

extension POIVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POICell
        
        let poi = pois[indexPath.row]
        cell.poi = poi
        
        return cell
    }
    
    
}

extension POIVC:UITableViewDelegate{
    
}
