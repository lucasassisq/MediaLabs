import UIKit
import Foundation

public extension String {
    
    static let baseUrl = "https://cdev3.mercantil.com.br/mb.webapi.services.ibk/api"
    
    // to enable mockoon tool usage:
    // static let baseUrl = "http://192.168.0.73:3000/api"
    
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    var currencyStringToDouble: Double {
        let formatter = NumberFormatter()
        let str = self.replacingOccurrences(of: " ", with: "")
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_br")
        let number = formatter.number(from: str)
        
        return number?.doubleValue ?? 0.0
    }
    
    var toDate: Date? {
        if let date = Date.Formatter.customDate.date(from: self) {
            return date
        }
        
        return nil
    }
    
    var toDateStringBRFormatter: String? {
        return self.components(separatedBy: "-").reversed().joined(separator: "/")
    }
    
    var accountMask: String {
        return self.replacingOccurrences(of: "^(\\d{8})(\\d{1})$", with: "$1-$2", options: .regularExpression)
    }
    
    var longerAccountMask: String {
        return self.replacingOccurrences(of: "^(\\d{12})(\\d{1})$", with: "$1-$2", options: .regularExpression)
    }
    
    var benefitMask: String {
        return self.replacingOccurrences(of: "^(\\d{9})(\\d{1})$", with: "$1-$2", options: .regularExpression)
    }
    
    var length: Int {
        get {
            return self.count
        }
    }
    
    var removeSpecialChars: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890-")
        return self.filter {okayChars.contains($0) }
    }
    
    var removeEmoji: String {
        return self.components(separatedBy: CharacterSet.symbols).joined()
    }
    
    var alphanumeric: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    }
    
    var alphanumericWithWhiteSpace: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.union(.whitespaces).inverted).joined()
    }
    
    var lettersWithWhiteSpace: String {
        return self.components(separatedBy: CharacterSet.letters.union(.whitespaces).inverted).joined()
    }
    
    var numbers: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    private var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        
        do {
            return try NSAttributedString(data: data,
                                          options: [
                                            .documentType: NSAttributedString.DocumentType.html,
                                            .characterEncoding: String.Encoding.utf8.rawValue
                                          ], documentAttributes: nil)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    var formatedAsCpfOrCnpj: String {
        let input = removeSeparators()
        if input.count <= 11 {
            return input.formatedAsCPF
        }
        return input.formatedAsCNPJ
    }
    
    var formatedAsCPF: String {
        var input = self.removeSeparators()
        while input.count > 11 {
            input.removeLast()
        }
        var result = ""
        for (index, char) in input.enumerated() {
            if index == 3 || index == 6 {
                result.append(".")
            } else if index == 9 {
                result.append("-")
            }
            result.append(char)
        }
        return result
    }
    
    var formatedAsCEP: String {
        var input = self.removeSeparators()
        while input.count > 8 {
            input.removeLast()
        }
        var result = ""
        for (index, char) in input.enumerated() {
            if index == 5 {
                result.append("-")
            }
            result.append(char)
        }
        return result
    }
    
    var formatedAsCNPJ: String {
        var input = self.removeSeparators()
        while input.count > 14 {
            input.removeLast()
        }
        var result = ""
        for (index, char) in input.enumerated() {
            if index == 2 || index == 5 {
                result.append(".")
            } else if index == 8 {
                result.append("/")
            } else if index == 12 {
                result.append("-")
            }
            result.append(char)
        }
        return result
    }
    
    var formatedAsRandomKey: String {
        var input = self.removeSeparators()
        while input.count > 36 {
            input.removeLast()
        }
        var result = ""
        for (index, char) in input.enumerated() {
            if index == 8 || index == 12 || index == 16 || index == 20 {
                result.append("-")
            }
            result.append(char)
        }
        return result
    }
    
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return self.filter {okayChars.contains($0) }
    }
    
    var formatToCurrency: String {
        let formatter = NumberFormatter()
        formatter.locale = .init(identifier: "PT-BR")
        formatter.numberStyle = .currencyAccounting
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amount = self
        
        do {
            let regex = try NSRegularExpression(pattern: "[^-?[0-9]]", options: .caseInsensitive)
            amount = regex.stringByReplacingMatches(in: amount,
                                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                    range: NSRange(location: 0, length: self.count),
                                                    withTemplate: "")
            
            let double = (amount as NSString).doubleValue
            let number = NSNumber(value: (double / 100))
            
            guard number != 0 as NSNumber else {
                return ""
            }
            
            guard let formattedString = formatter.string(from: number) else {
                return ""
            }
            
            return formattedString
            
        } catch {
            return ""
        }
    }
    
    var removeCurrency: String {
        let value = self.replacingOccurrences(of: "R$", with: "")
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var removeCPFMask: String {
        let cpfNumbers = self.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
        return cpfNumbers.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var formatedPhone: String {
        return formatPhone()
    }
    
    var formatedRegularPhone: String {
        return formatPhone(mask: "(XX) XXXX-XXXX", replacingAsterisks: false)
    }
    
    var stringByRemovingWhitespaces: String {
        return self.replacingOccurrences(of: "^\\s+|\\s+|\\s+$",
                               with: "",
                               options: .regularExpression)
    }
    
    var isValidCPF: Bool {
        let cpf = self.numbers
        guard cpf.count == 11 else { return false }
        
        if cpf == "11111111111" {
            return false
        } else if cpf == "22222222222" {
            return false
        } else if cpf == "33333333333" {
            return false
        } else if cpf == "44444444444" {
            return false
        } else if cpf == "55555555555" {
            return false
        } else if cpf == "66666666666" {
            return false
        } else if cpf == "77777777777" {
            return false
        } else if cpf == "88888888888" {
            return false
        } else if cpf == "99999999999" {
            return false
        } else if cpf == "00000000000" {
            return false
        }
        
        
        let i1 = cpf.index(cpf.startIndex, offsetBy: 9)
        let i2 = cpf.index(cpf.startIndex, offsetBy: 10)
        let i3 = cpf.index(cpf.startIndex, offsetBy: 11)
        let d1 = Int(cpf[i1..<i2])
        let d2 = Int(cpf[i2..<i3])
        
        var temp1 = 0, temp2 = 0
        
        for i in 0...8 {
            let start = cpf.index(cpf.startIndex, offsetBy: i)
            let end = cpf.index(cpf.startIndex, offsetBy: i+1)
            if let char = Int(cpf[start..<end]) {
                temp1 += char * (10 - i)
                temp2 += char * (11 - i)
            }
        }
        
        temp1 %= 11
        temp1 = temp1 < 2 ? 0 : 11-temp1
        
        temp2 += temp1 * 2
        temp2 %= 11
        temp2 = temp2 < 2 ? 0 : 11-temp2
        
        return temp1 == d1 && temp2 == d2
    }
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool {
        let phoneRegex = "^\\([1-9]{2}\\) 9[0-9]{1}[0-9]{3}\\-[0-9]{4}$"
        let phoneTest  = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    var isValidURL: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
                return match.range.length == self.utf16.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func isValidPhone(phoneNumber: String) -> Bool {
        let phoneRegex = "^\\([1-9]{2}\\) 9[0-9]{1}[0-9]{3}\\-[0-9]{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result = phoneTest.evaluate(with: phoneNumber)
        return result
    }
    
    func hasThreeConsecutiveLetters() -> Bool {
        var charCounter = 0
        var lastChar: Character? = nil
        for character in self {
            if lastChar == nil {
                lastChar = character
                continue
            }
            
            if character == lastChar {
                charCounter += 1
            } else {
                charCounter = 0
            }
            
            if charCounter >= 2 {
                return true
            }
            lastChar = character
        }
        return false
    }
    
    func hasAtLeastTwoDifferentLetters() -> Bool {
        var firstLetter: Character? = nil
        
        for character in self {
            if firstLetter == nil {
                firstLetter = character
                continue
            }
            
            if character != firstLetter {
                return true
            }
        }
        return false
    }
    
    func hasAtLeastOneSpace() -> Bool {
        var hasSpace = false
        var lastChar: Character? = nil
        var spacesCount = 0
        for character in self {
            if character == " " {
                hasSpace = true
                spacesCount += 1
            }
            lastChar = character
        }
        
        if lastChar != " " {
            return hasSpace
        }
        
        if spacesCount >= 2 {
            if lastChar != " " {
                return hasSpace
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func isCurrentDateOrBigger() -> Bool {
        let currentDate = Date()
        let date = self.toDate ?? Date()
        return currentDate <= date
    }
    
    func isUnder18() -> Bool {
        let currentYear = Calendar.current.component(.year, from: Date())
        let dateYear = Calendar.current.component(.year, from: self.toDate ?? Date())
        return currentYear <= (dateYear+17)
    }
    
    func isUnder150() -> Bool {
        let currentYear = Calendar.current.component(.year, from: Date())
        let dateYear = Calendar.current.component(.year, from: self.toDate ?? Date())
        return (currentYear - 150) >= dateYear
    }
    
    func currencyStringToDouble(places: Int = 2) -> Double {
        let formatter = NumberFormatter()
        let str = self.replacingOccurrences(of: " ", with: "")
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_br")
        formatter.maximumFractionDigits = places
        let number = formatter.number(from: str)
        
        return number?.doubleValue ?? 0.0
    }
    
    func removeSeparators() -> String {
        var result = self.replacingOccurrences(of: "-", with: "")
        result = result.replacingOccurrences(of: ".", with: "")
        result = result.replacingOccurrences(of: "/", with: "")
        result = result.replacingOccurrences(of: " ", with: "")
        result = result.replacingOccurrences(of: "(", with: "")
        result = result.replacingOccurrences(of: ")", with: "")
        return result
    }
    
    // right is the first encountered string after left
    func between(_ left: String, _ right: String) -> String? {
        guard
            let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards),
            leftRange.upperBound <= rightRange.lowerBound
        else { return nil }
        
        let sub = self[leftRange.upperBound...]
        if let closestToLeftRange = sub.range(of: right) {
            return String(sub[..<closestToLeftRange.lowerBound])
        }
        
        return nil
    }
    
    func lastIndexOfCharacter(_ c: Character) -> Int? {
        guard let index = range(of: String(c), options: .backwards)?.lowerBound else
        { return nil }
        return distance(from: startIndex, to: index)
    }
    
    func substring(to: Int) -> String {
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[...toIndex])
    }
    
    func substring(from: Int) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }
    
    func substring(_ r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        let indexRange = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return String(self[indexRange])
    }
    
    func character(_ at: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: at)]
    }
    
    func parse<D>(to type: D.Type) -> D? where D: Decodable {
        
        if let data: Data = self.data(using: .utf8) {
            let decoder = JSONDecoder()
            
            do {
                let _object = try decoder.decode(type, from: data)
                return _object
                
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        
        return nil
    }
    
    func currencyInputFormatting(currencySymbol: String = "R$") -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = currencySymbol
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")
        
        var amount = self
        do {
            let regex = try NSRegularExpression(pattern: "[^-?[0-9]]", options: .caseInsensitive)
            amount = regex.stringByReplacingMatches(in: amount, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count), withTemplate: "")
        } catch {
            print(error.localizedDescription)
        }
        
        let double = (amount as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number) ?? ""
    }
    
    func unaccent() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
    
    func convertHtmlToAttributedStringWithCSS(font: UIFont?, csscolor: String, lineheight: Int, csstextalign: String) -> NSAttributedString? {
        guard let font = font else {
            return convertHtmlToNSAttributedString
        }
        
        let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; text-align: \(csstextalign); }</style>\(self)";
        
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        
        do {
            return try NSAttributedString(data: data,
                                          options: [
                                            .documentType: NSAttributedString.DocumentType.html,
                                            .characterEncoding: String.Encoding.utf8.rawValue
                                          ], documentAttributes: nil)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    

    func components(withMaxLength length: Int) -> [String] {
            return stride(from: 0, to: self.count, by: length).map {
                let start = self.index(self.startIndex, offsetBy: $0)
                let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
                return String(self[start..<end])
            }
    }
    func formatDateFrom(currentPattern: String, toNewFormatt: String = "dd/MM/yyyy") -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = currentPattern
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = toNewFormatt
        
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
            return nil
        }

    }
    
    func applyBarCodeMask(mask: String) -> String {
        let codbar = self.numbers
        var result = ""
        var index = codbar.startIndex
        for ch in mask where index < codbar.endIndex {
            if ch == "0" {
                result.append(codbar[index])
                index = codbar.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }

    // MARK: - Private methods
    
    private func formatPhone(mask: String = "(XX) XXXXX-XXXX", replacingAsterisks: Bool = false) -> String {
        let cleanPhoneNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
                if replacingAsterisks && ch == "*" {
                    index = cleanPhoneNumber.index(after: index)
                }
            }
        }
        return result
    }
    
    func replaceFirstAccessField(field: String, quantity: String) -> String {
        return replacingOccurrences(of: "{0}", with: field).replacingOccurrences(of: "{1}", with: quantity)
    }
    
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string (default is "...").
    @discardableResult
    mutating func truncate(toLength length: Int, trailing: String? = "...") -> String {
        guard length > 0 else { return self }
        if count > length {
            self = self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
        }
        return self
    }
}

// MARK: - Subscripts

extension String {
    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    subscript (r: CountableClosedRange<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        let indexRange = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return String(self[indexRange])
    }
}

public extension StringProtocol {
    func indexF<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndexF<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indicesF<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        rangesF(of: string, options: options).map(\.lowerBound)
    }
    func rangesF<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...]
                .range(of: string, options: options) {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
            index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var removingAllWhitespaces: Self {
        filter(\.isWhitespace.negated)
    }
    mutating func removeAllWhitespaces() {
        removeAll(where: \.isWhitespace)
    }
}

extension Bool {
    var negated: Bool { !self }
}
