//
//  RecipeHandler.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 02/11/2020.
//

import Foundation

class ColorFormatter: Formatter {
    
    override func string(for obj: Any?) -> String? {
        
        if let color = obj as? String {
            return color
        }
        
        return ""
    }
        
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        obj?.pointee = string as AnyObject
        
        return true
    }
}

class IBUFormatter: Formatter {
    
    override func string(for obj: Any?) -> String? {
        
        if let ibu = obj as? String {
            return ibu
        }
        
        return ""
    }
        
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        obj?.pointee = string as AnyObject
        return true
    }
}

class ABVFormatter: Formatter {
    
    
    private func convert(abv: String) -> String {
        
        guard let val = Float(abv) else  {
            return abv
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let str = formatter.string(from: NSNumber(value: val / 10)) {
            return "\(str)%"
        }
        
        return abv
    }
    
    override func string(for obj: Any?) -> String? {
        
        if let abv = obj as? String {
        
            return convert(abv: abv)
            
        }
        
        return ""
    }
        
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        obj?.pointee = convert(abv:string) as AnyObject
        
        return true
    }
    
}
