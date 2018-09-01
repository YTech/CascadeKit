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
import UIKit

import CascadeKit

class ViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var textView: UITextView!

    private let viewModel = LanguagesViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupAttributes()
    }

    private func setupAttributes() {
        self.textView.attributedText = self.viewModel.attributedText()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.viewModel.availableAlphabets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlphabetCell", for: indexPath)

        guard let currentAlphabet = self.viewModel.alphabet(at: indexPath.row) else {
            fatalError("Sorry dudes, something wrong happened")
        }
        cell.textLabel?.text = currentAlphabet.rawValue

        #if swift(>=4.2)
        cell.accessoryType = self.viewModel.isAlphabetSelected(alphabet: currentAlphabet) ? UITableViewCell.AccessoryType.checkmark : UITableViewCell.AccessoryType.none
        #else
        cell.accessoryType = self.viewModel.isAlphabetSelected(alphabet: currentAlphabet) ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
        #endif

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ = self.viewModel.clickedOnAlphabet(at: indexPath.row)

        DispatchQueue.main.async {
            self.setupAttributes()
            self.tableView.reloadData()
        }
    }
}
