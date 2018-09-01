// MIT License
//
// Copyright YOOX NET-A-PORTER (c) 2018
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
import Foundation

import CascadeKit

class LanguagesViewModel {
    private (set) var selectedAlphabets: [Int] = []
    var availableAlphabets: [Alphabet] = Alphabet.available

    private let text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam viverra luctus libero, non ultrices tortor maximus at. Maecenas cursus, metus nec tincidunt vestibulum, orci arcu feugiat augue, quis egestas nulla eros at nibh.\n\nЦонвенире реформиданс еи сед. Maecenas mattis tristique urna, quis commodo ipsum elementum non. Etiam facilisis sapien et dui luctus, quis lacinia ante mattis. Vestibulum ut porttitor elit, nec suscipit leo. Nullam libero dolor, varius eu varius quis, tincidunt in diam. Ut fringilla ante quis suscipit eleifend. In in auctor felis, at tempus dui.\n\nМеа елитр нонумес цонцлудатуряуе ин. Либер видерер еос цу, еирмод нонумес инцоррупте усу еи. Етиам аудире долорум ад про.\n\nΟἱ δὲ Φοίνιϰες οὗτοι οἱ σὺν Κάδμῳ ἀπιϰόμενοι.. ἐσήγαγον διδασϰάλια ἐς τοὺς ῞Ελληνας ϰαὶ δὴ ϰαὶ γράμματα, οὐϰ ἐόντα πρὶν ῞Ελλησι ὡς ἐμοὶ δοϰέειν, πρῶτα μὲν τοῖσι ϰαὶ ἅπαντες χρέωνται Φοίνιϰες· μετὰ δὲ χρόνου προβαίνοντος ἅμα τῇ ϕωνῇ μετέβαλον ϰαὶ τὸν ϱυϑμὸν τῶν γραμμάτων."

    func attributedText() -> NSMutableAttributedString {

        guard self.selectedAlphabets.count > 0 else {
            return NSMutableAttributedString(string: text)
        }

        return NSMutableAttributedString(string: text).addAttributes(for: self.selectedAlphabets.map { self.availableAlphabets[$0] },
                                                                     avoiding: [.whiteSpace]) {
                                                                        self.applyAttributes(fallback: $0)
        }
    }

    func clickedOnAlphabet(at index: Int) -> [Alphabet] {
        let computedIndex = self.selectedAlphabets.index(of: index)
        guard computedIndex != nil else {
            self.selectedAlphabets.append(index)

            let convertedAlphabets = self.selectedAlphabets.map { self.availableAlphabets[$0] }
            return convertedAlphabets
        }

        self.selectedAlphabets.remove(at: computedIndex!)

        let convertedAlphabets = self.selectedAlphabets.map { self.availableAlphabets[$0] }
        return convertedAlphabets
    }

    func alphabet(at index: Int) -> Alphabet? {
        guard index < self.availableAlphabets.count else { return nil }

        return self.availableAlphabets[index]
    }

    func isAlphabetSelected(alphabet: Alphabet) -> Bool {
        guard let index = self.availableAlphabets.index(of: alphabet) else { return false }
        return self.selectedAlphabets.contains(index)
    }
}

extension LanguagesViewModel {
    fileprivate func applyAttributes(fallback: Fallback) -> [Attribute] {
        let foregroundColor = self.foreground(for: fallback.type)
        let backgroundColor = self.background(for: fallback.type)

        let colorAttribute = Attribute(key: .foregroundColor,
                                       value: foregroundColor,
                                       range: fallback.range)

        let backgroundAttribute = Attribute(key: .backgroundColor,
                                            value: backgroundColor,
                                            range: fallback.range)

        return [colorAttribute, backgroundAttribute]
    }

    fileprivate func foreground(for alphabet: Alphabet) -> UIColor {
        switch alphabet {
        case .arabic: return UIColor.yellow
        case .greek, .greekExtended: return UIColor.white
        case .latin, .latinSupplementary: return UIColor.red
        case .myanmar: return UIColor.orange
        case .russian, .russianSupplementary: return UIColor.purple
        }
    }

    fileprivate func background(for alphabet: Alphabet) -> UIColor {
        switch alphabet {
        case .arabic: return UIColor.black
        case .greek, .greekExtended: return UIColor.blue
        case .latin, .latinSupplementary: return UIColor.yellow
        case .myanmar: return UIColor.white
        case .russian, .russianSupplementary: return UIColor.white
        }
    }
}
