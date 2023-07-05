
extension Array {
    public func `get`(_ index: Int) -> Element? {
        if index < 0 || index >= count {
            return nil
        }
        
        return self[index]
    }
}
