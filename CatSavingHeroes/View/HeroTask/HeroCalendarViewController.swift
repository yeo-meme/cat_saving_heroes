//
//  HeroCalendarViewController.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/06.
//

import UIKit

class HeroCalendarViewController: UIViewController {

    lazy var dateView: UICalendarView = {
        var view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsDateDecorations = true
        return view
    }()
    
    var selectedDate: DateComponents? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        applyConstraints()
        setCalendar()
        reloadDateView(date: Date())
    }

    fileprivate func setCalendar() {
        dateView.delegate = self

        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateView.selectionBehavior = dateSelection
    }
    
    fileprivate func applyConstraints() {
        view.addSubview(dateView)
        
        let dateViewConstraints = [
            dateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ]
        NSLayoutConstraint.activate(dateViewConstraints)
    }
    
    func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        dateView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
}

func createImageViews(systemNames: [String], tintColors: [UIColor]) -> [UIImageView] {
    var imageViews = [UIImageView]()

    for (index, systemName) in systemNames.enumerated() {
        let imageView = UIImageView(image: UIImage(systemName: systemName))
        imageView.tintColor = tintColors[index]
        imageView.frame = CGRect(
            x: CGFloat(index) * (7 + 2),
            y: 0,
            width: 7,
            height: 7
        )
        imageViews.append(imageView)
    }

    return imageViews
}

extension HeroCalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {

    func calendarView(_ calendarView: UICalendarView, didChangeVisibleDateComponentsFrom previousDateComponents: DateComponents) {
    }

    // UICalendarView
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if let selectedDate = selectedDate, selectedDate == dateComponents {
            return .customView {
                let label = UILabel()
                label.text = "🐶"
                label.textAlignment = .center
                return label
            }
        } else if dateComponents.day == 6 && dateComponents.month == 10 {
            return .customView {
                let systemNames = ["star.fill", "triangle.fill", "square.fill", "circle.fill", "heart.fill"]
                let tintColors: [UIColor] = [.purple, .green, .blue, .brown, .red]
                let imageViews = createImageViews(systemNames: systemNames, tintColors: tintColors)
                let containerView = UIView()
                containerView.frame = CGRect(x: -10, y: 10, width: CGFloat(systemNames.count) * (7 + 2), height: 7)
                for imageView in imageViews {
                    containerView.addSubview(imageView)
                }
                return containerView
            }
        } else if dateComponents.day == 10 && dateComponents.month == 10 {
            return .customView {
                let systemNames = ["triangle.fill", "square.fill", "heart.fill"]
                let tintColors: [UIColor] = [.green, .blue, .red]
                let imageViews = createImageViews(systemNames: systemNames, tintColors: tintColors)
                let containerView = UIView()
                containerView.frame = CGRect(x: -10, y: 10, width: CGFloat(systemNames.count) * (7 + 2), height: 7)
                for imageView in imageViews {
                    containerView.addSubview(imageView)
                }
                return containerView
            }
        } else if dateComponents.day == 15 && dateComponents.month == 10 {
            return .customView {
                let systemNames = ["star.fill", "triangle.fill", "heart.fill"]
                let tintColors: [UIColor] = [.purple, .green, .red]
                let imageViews = createImageViews(systemNames: systemNames, tintColors: tintColors)
                let containerView = UIView()
                containerView.frame = CGRect(x: -10, y: 10, width: CGFloat(systemNames.count) * (7 + 2), height: 7)
                for imageView in imageViews {
                    containerView.addSubview(imageView)
                }
                return containerView
            }
        } else if dateComponents.day == 19 && dateComponents.month == 10 {
            return .customView {
                let systemNames = ["circle.fill", "heart.fill"]
                let tintColors: [UIColor] = [.brown, .red]
                let imageViews = createImageViews(systemNames: systemNames, tintColors: tintColors)
                let containerView = UIView()
                containerView.frame = CGRect(x: -10, y: 10, width: CGFloat(systemNames.count) * (7 + 2), height: 7)
                for imageView in imageViews {
                    containerView.addSubview(imageView)
                }
                return containerView
            }
        }
        return nil
    }
    
    // 달력에서 날짜 선택했을 경우
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        reloadDateView(date: Calendar.current.date(from: dateComponents!))
    }
}
