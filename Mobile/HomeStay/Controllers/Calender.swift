//
//  Calender.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 29/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import CVCalendar

class Calender: UIViewController,CVCalendarViewDelegate,CVCalendarMenuViewDelegate {
    
    // MARK:- Outlets
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        // Appearance delegate [Unnecessary]
        self.calendarView.calendarAppearanceDelegate = self
        // Animator delegate [Unnecessary]
        self.calendarView.animatorDelegate = self
        // Menu delegate [Required]
        self.menuView.menuViewDelegate = self
        // Calendar delegate [Required]
        self.calendarView.calendarDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return Weekday.monday
    }
}
