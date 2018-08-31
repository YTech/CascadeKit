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
    private (set) var selectedAlphabets: [Alphabet] = []
    var availableAlphabets: [Alphabet] = Alphabet.available

    private let text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam viverra luctus libero, non ultrices tortor maximus at. Maecenas cursus, metus nec tincidunt vestibulum, orci arcu feugiat augue, quis egestas nulla eros at nibh.\n\nЦонвенире реформиданс еи сед. Maecenas mattis tristique urna, quis commodo ipsum elementum non. Etiam facilisis sapien et dui luctus, quis lacinia ante mattis. Vestibulum ut porttitor elit, nec suscipit leo. Nullam libero dolor, varius eu varius quis, tincidunt in diam. Ut fringilla ante quis suscipit eleifend. In in auctor felis, at tempus dui.\n\nМеа елитр нонумес цонцлудатуряуе ин. Либер видерер еос цу, еирмод нонумес инцоррупте усу еи. Етиам аудире долорум ад про.\n\nΟἱ δὲ Φοίνιϰες οὗτοι οἱ σὺν Κάδμῳ ἀπιϰόμενοι.. ἐσήγαγον διδασϰάλια ἐς τοὺς ῞Ελληνας ϰαὶ δὴ ϰαὶ γράμματα, οὐϰ ἐόντα πρὶν ῞Ελλησι ὡς ἐμοὶ δοϰέειν, πρῶτα μὲν τοῖσι ϰαὶ ἅπαντες χρέωνται Φοίνιϰες· μετὰ δὲ χρόνου προβαίνοντος ἅμα τῇ ϕωνῇ μετέβαλον ϰαὶ τὸν ϱυϑμὸν τῶν γραμμάτων."

    func attributedText() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: text).addAttributes(for: self.selectedAlphabets,
                                                                     avoiding: [.whiteSpace]) {
                                                                        self.applyAttributes(fallback: $0)
        }
    }

    func addAlphabet(alphabet: Alphabet) {
        self.selectedAlphabets.append(alphabet)
    }

    func removeAlphabet(alphabet: Alphabet) {
        self.selectedAlphabets = self.selectedAlphabets.filter { $0 != alphabet }
    }
}

extension LanguagesViewModel {
    fileprivate func applyAttributes(fallback: Fallback) -> [Attribute] {
        let foregroundColor = fallback.type == .russian ? UIColor.red : UIColor.white
        let backgroundColor = fallback.type == .russian ? UIColor.yellow : UIColor.blue

        let colorAttribute = Attribute(key: .foregroundColor,
                                       value: foregroundColor,
                                       range: fallback.range)

        let backgroundAttribute = Attribute(key: .backgroundColor,
                                            value: backgroundColor,
                                            range: fallback.range)

        return [colorAttribute, backgroundAttribute]
    }
}
