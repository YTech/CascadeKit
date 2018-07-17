//
//  Copyright © YOOX NET-A-PORTER 2018. All rights reserved.
//
import UIKit

import CascadeKit

class ViewController: UIViewController {
    private let text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam viverra luctus libero, non ultrices tortor maximus at. Maecenas cursus, metus nec tincidunt vestibulum, orci arcu feugiat augue, quis egestas nulla eros at nibh.\n\nЦонвенире реформиданс еи сед. Maecenas mattis tristique urna, quis commodo ipsum elementum non. Etiam facilisis sapien et dui luctus, quis lacinia ante mattis. Vestibulum ut porttitor elit, nec suscipit leo. Nullam libero dolor, varius eu varius quis, tincidunt in diam. Ut fringilla ante quis suscipit eleifend. In in auctor felis, at tempus dui.\n\nМеа елитр нонумес цонцлудатуряуе ин. Либер видерер еос цу, еирмод нонумес инцоррупте усу еи. Етиам аудире долорум ад про.\n\nΟἱ δὲ Φοίνιϰες οὗτοι οἱ σὺν Κάδμῳ ἀπιϰόμενοι.. ἐσήγαγον διδασϰάλια ἐς τοὺς ῞Ελληνας ϰαὶ δὴ ϰαὶ γράμματα, οὐϰ ἐόντα πρὶν ῞Ελλησι ὡς ἐμοὶ δοϰέειν, πρῶτα μὲν τοῖσι ϰαὶ ἅπαντες χρέωνται Φοίνιϰες· μετὰ δὲ χρόνου προβαίνοντος ἅμα τῇ ϕωνῇ μετέβαλον ϰαὶ τὸν ϱυϑμὸν τῶν γραμμάτων."

    @IBOutlet private weak var textLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttributes()
    }

    // MARK: - Private methods
    private func setupAttributes() {
        textLabel.attributedText = NSMutableAttributedString(string: text).addAttributes(for: [.russian, .greek, .greekExtended],
                                                                                         avoiding: [.whiteSpace]) {
                                                                                            self.applyAttributes(fallback: $0)
        }
    }

    private func applyAttributes(fallback: Fallback) -> [Attribute] {
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
