//
//  POIVC-KeywordsSearch.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/25.
//

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
        ()
        keywordsSearchRequest.keywords = keywords
        footer.setRefreshingTarget(self, refreshingAction: #selector(keywordsSearchPullToRefresh))
        showLoadHUD()
        mapSearch?.aMapPOIKeywordsSearch(keywordsSearchRequest)
    }
}


//所有搜索api的回调
extension POIVC : AMapSearchDelegate{
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        let poiCount = response.count
        hideLoadHUD()
        
        if poiCount > kPOIsOffset{
            pageCount = response.count / kPOIsOffset + 1
        }else{
            footer.endRefreshingWithNoMoreData()
        }
        
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
        
        
        tableview.reloadData()
    }
}

extension POIVC{
    private func makeKeywordsSearch(){
        
    }
}

//关键字下拉刷新
extension POIVC{
    @objc private func keywordsSearchPullToRefresh(){
        
    }
}
