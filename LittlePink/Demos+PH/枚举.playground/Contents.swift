class stateItr : IteratorProtocol{
    
    var num:Int = 1
    func next() -> Int? {
        num += 2
        return num
    }
    
}

func findNext<I: IteratorProtocol>(elm: I) -> AnyIterator<I.Element> where I.Element == Int{
        var l = elm
        print("\(l.next() ?? 0)")
        return AnyIterator{l.next()}
    }


findNext(elm:  stateItr()).next()
