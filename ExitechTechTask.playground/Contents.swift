import Foundation

// Implement mobile phone storage protocol
// Requirements:
// - Mobiles must be unique (IMEI is an unique number)
// - Mobiles must be stored in memory

protocol MobileStorage {
func getAll() -> Set<Mobile>
func findByImei(_ imei: String) -> Mobile?
func save(_ mobile: Mobile) throws -> Mobile
func delete(_ product: Mobile) throws
func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
let imei: String
let model: String
}

enum MobileErrors: Error {
    case noMobile
    case nothingToDelete
}

class MobileStorageImpl: MobileStorage {
    var mobiles: Set<Mobile> = []
    
    func getAll() -> Set<Mobile> {
        return mobiles
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        var mobile: Mobile?
        mobiles.forEach {
            if $0.imei == imei {
                mobile = $0
            }
        }
        return mobile
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        if mobiles.contains(mobile) {
            throw MobileErrors.noMobile
        } else {
            mobiles.insert(mobile)
        }
        return mobile
    }
    
    func delete(_ product: Mobile) throws {
        if mobiles.contains(product) {
            mobiles.remove(product)
        } else {
            throw MobileErrors.nothingToDelete
        }
    }
    
    func exists(_ product: Mobile) -> Bool {
        return mobiles.contains(product)
    }
}
