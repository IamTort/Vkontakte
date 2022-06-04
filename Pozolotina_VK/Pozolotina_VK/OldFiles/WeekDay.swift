//
//  WeekDayPicker.swift
//  Pozolotina_VK
//
//  Created by angelina on 19.04.2022.
//
//
//import UIKit
//
//enum Day: Int {
//
//    case q,w,e,r,t,y,u,i,o,p,a,s,d,f,g,h,j,k,l,z,x,c,v,b,n,m
//
//    static let allDays: [Day] = [a, n, s]
//    var title: String {
//        switch self {
//        case .a: return "a"
//        case .z: return "z"
//        case .q: return "q"
//        case .w: return "w"
//        case .e: return "e"
//        case .r: return "r"
//        case .t: return "t"
//        case .y: return "y"
//        case .u: return "u"
//        case .i: return "i"
//        case .o: return "o"
//        case .p: return "p"
//        case .s: return "s"
//        case .d: return "d"
//        case .f: return "f"
//        case .g: return "g"
//        case .h: return  "h"
//        case .j: return "j"
//        case .k: return "k"
//        case .l: return "l"
//        case .x: return  "x"
//        case .c: return "c"
//        case .v: return "v"
//        case .b: return "b"
//        case .n: return "n"
//        case .m: return "m"
//        }
//
//    }
//}
//
//     //@IBDesignable
//class WeekDayPicker: UIControl {
//
//    var selectedDay: Day? = nil {
//        didSet {
//        self.updateSelectedDay()
//        self.sendActions(for: .valueChanged)
//        }
//
//    }
//
//    private var buttons: [UIButton] = []
//
//    private var stackView: UIStackView!
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setupView()
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.setupView()
//
//    }
//
//    private func setupView() {
//        for day in Day.allDays {
//
//            let button = UIButton(type: .system)
//            button.setTitle(day.title, for: .normal)
//            button.setTitleColor(.lightGray, for: .normal)
//            button.setTitleColor(.white, for: .selected)
//            button.addTarget(self, action: #selector(selectDay(_:)), for: .touchUpInside)
//            self.buttons.append(button)
//
//        }
//
//        stackView = UIStackView(arrangedSubviews: self.buttons)
//
//        self.addSubview(stackView)
//
//        stackView.spacing = 8
//        stackView.axis = .vertical
//        stackView.alignment = .leading
//        stackView.distribution = .fillEqually
//    }
//
//    private func updateSelectedDay() {
//
//        for (index, button) in self.buttons.enumerated() {
//            guard let day = Day(rawValue: index) else { continue }
//            button.isSelected = day == self.selectedDay
//
//        }
//    }
//
//    @objc private func selectDay(_ sender: UIButton) {
//        guard let index = self.buttons.firstIndex(of: sender) else { return }
//        guard let day = Day(rawValue: index) else { return }
//        self.selectedDay = day
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        stackView.frame = bounds
//    }
//
//}
