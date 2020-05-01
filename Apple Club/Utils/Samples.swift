//
//  Samples.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/5.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

extension Store{
    static func Sample() -> Store{
        let store = Store()
        store.appState.newsState.newsListViewModel.updateNews(newsList: News.all)
        store.appState.calendarState.calendarViewModel.updateEvents(with: Event.all)
        return store
    }
}

extension News{
    static func Sample(id: Int) -> News{
        return FileHelper.loadBundleJSON(file: "news-\(id)")
    }
    
    static var all: [News] = {
        (1...5).map{ id in
            let news = News.Sample(id: id)
            return news
        }
    }()
}

extension NewsViewModel{
    static var all: [NewsViewModel] = {
        (1...5).map { id in
            let news = News.Sample(id: id)
            return NewsViewModel(news: news)
        }
    }()
    
    static func Sample(id: Int) -> NewsViewModel{
        return NewsViewModel(news: News.Sample(id: id))
    }
}

extension User{
    static func Sample() -> User{
        return FileHelper.loadBundleJSON(file: "user-sample")
    }
}

//extension UserInfo{
//    static func Sample() -> UserInfo{
//        return UserInfo(id: 0, userName: "Jooc", avatar: "http://iosclub-resources.oss-cn-hangzhou.aliyuncs.com/avatar/avatar.png", universityCode: 0)
//    }
//}

extension MeViewModel{
    static func Sample() -> MeViewModel{
        return MeViewModel(user: User.Sample())
    }
}

extension EDayViewModel{
    static func Sample(date: Int?, state: EDayState) -> EDayViewModel{
        switch state {
        case .uncover: return EDayViewModel(model: EDay(year: 2020, month: 1, date: date ?? 31), state: .uncover)
        case .available: return EDayViewModel(model: EDay(year: 2020, month: 1, date: date ?? 1), state: .available)
        case .selected:
            let viewModel = EDayViewModel(model: EDay(year: 2020, month: 1, date: date ?? 2), state: .selected)
            viewModel.events.append(Event.all[0])
            return viewModel
        case .unavailable: return EDayViewModel(model: EDay(year: 2020, month: 1, date: date ?? 3), state: .unavailable)
        }
    }
}

extension EWeekViewModel{
    static func Sample() -> EWeekViewModel{
        let viewModel = EWeekViewModel()
        viewModel.days.append(EDayViewModel.Sample(date: 31, state: .uncover))
        viewModel.days.append(EDayViewModel.Sample(date: 1, state: .available))
        viewModel.days.append(EDayViewModel.Sample(date: 2, state: .available))
        viewModel.days.append(EDayViewModel.Sample(date: 3, state: .available))
        viewModel.days.append(EDayViewModel.Sample(date: 4, state: .available))
        viewModel.days.append(EDayViewModel.Sample(date: 5, state: .selected))
        viewModel.days.append(EDayViewModel.Sample(date: 6, state: .available))
        return viewModel
    }
}

extension EMonthViewModel{
    static func Sample() -> EMonthViewModel{
        let viewModel = EMonthViewModel(month: 1)
        viewModel.generateMonth(baseWeekday: .Tuesday, preCount: 31, curCount: 31)
        return viewModel
    }
}

extension CalendarViewModel{
    static func Sample() -> CalendarViewModel{
        var viewModel = CalendarViewModel()
        viewModel.selectedDay = viewModel.months[3].weeks[2].days[3]
        viewModel.selectedDayPreState = EDayState.available

        return viewModel
    }
}

extension Event{
    static var all: [Event] = {
        (1...2).map{ id in
            let event:Event = FileHelper.loadBundleJSON(file: "event-\(id)")
            return event
        }
    }()
}
