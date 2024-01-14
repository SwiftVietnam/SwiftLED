//
//  Copyright © 2020 SwiftVietnam. All rights reserved.
//

import UIKit

class LampViewController: UIViewController {

    private let viewModel = ViewModel()
    private var colorSlider: ColorSlider!
    @IBOutlet private weak var `switch`: UISwitch!

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let previewView = DefaultPreviewView()
        previewView.side = .top
        previewView.animationDuration = 0.2
        previewView.offsetAmount = 40
        colorSlider = ColorSlider(orientation: .vertical, previewView: previewView)
        colorSlider.frame = .zero
        view.addSubview(colorSlider)

        colorSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            colorSlider.heightAnchor.constraint(equalToConstant: 400),
            colorSlider.widthAnchor.constraint(equalToConstant: 60)])

        colorSlider.addTarget(self, action: #selector(changedColor(_:)), for: .valueChanged)
        colorSlider.isEnabled = false
        colorSlider.alpha = 0.5
    }

    @objc func changedColor(_ slider: ColorSlider) {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        slider.color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        viewModel.change(hue: Int(hue * 360), saturation: Int(saturation * 100), brightness: Int(brightness * 100))
    }

    @IBAction func changedSwitch(_ sender: UISwitch) {
        let state: LEDState = sender.isOn ? .on : .off
        viewModel.switch(to: state) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.colorSlider.isEnabled = sender.isOn
                    self?.colorSlider.alpha = sender.isOn ? 1.0 : 0.5
                } else {
                    sender.isOn = !sender.isOn
                }
            }
        }
    }

    @IBAction func didTapRedLCD(_ sender: Any) {
        viewModel.changeLCD(.red) { success in

        }
    }

    @IBAction func didTapGreenLCD(_ sender: Any) {
        viewModel.changeLCD(.green) { success in

        }
    }

    @IBAction func didTapBlueLCD(_ sender: Any) {
        viewModel.changeLCD(.blue) { success in

        }
    }
}
