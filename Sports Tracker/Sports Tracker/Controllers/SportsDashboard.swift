//
//  SportsDashboard.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import UIKit

class SportsDashboard: UIViewController {
    
    // MARK: - Views
    private var sportsTableView: UITableView!
    private var errorView: ErrorView!
    private var loadingView: LoadingView!
    
    // MARK: - Data
    private var sports: [Sport]? {
        didSet {
            configureSportsTableViewModel()
        }
    }
    
    private var currentState: ViewState?
    private var previousState: ViewState?
    
    private var sportsTableViewModel = [SportsTableViewSectionViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        getSports()
    }
    
    private func setupViews() {
        view.backgroundColor = .cyanBlue
        
        sportsTableView = UITableView()
        sportsTableView.register(SportsTableViewCell.self, forCellReuseIdentifier: SportsTableViewCell.cellIdentifier)
        sportsTableView.delegate = self
        sportsTableView.dataSource = self
        sportsTableView.isScrollEnabled = true
        sportsTableView.rowHeight = UITableView.automaticDimension
        sportsTableView.clipsToBounds = false
        sportsTableView.backgroundColor = .clear
        sportsTableView.separatorStyle = .none
        sportsTableView.sectionHeaderTopPadding = 0
        sportsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        errorView = ErrorView()
        errorView.delegate = self
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupNavigationBar() {
        title = Text.sportsDashboardNavigationBarTitle.rawValue
        
        let appImageView = UIImageView(image: UIImage(named: ImageName.appIcon))
        appImageView.contentMode = .scaleAspectFit
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appImageView.heightAnchor.constraint(equalToConstant: Size.s32.rawValue),
            appImageView.widthAnchor.constraint(equalToConstant: Size.s32.rawValue),
        ])
        
        let barButtonItem = UIBarButtonItem(customView: appImageView)
        navigationItem.leftBarButtonItem = barButtonItem
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .navyBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    fileprivate func getSports() {
        applyState(.loading)
        
        getSports { [weak self] success in
            
            guard success else {
                self?.applyState(.error)
                return
            }
            
            self?.applyState(.success)
        }
    }
    
    private func configureSportsTableViewModel() {
        self.sports?.forEach { sport in
            var sportsTableViewSectionContentViewModels = [EventCellViewModel]()
            
            sport.events.forEach { event in
                let sportsTableViewSectionContentViewModel = EventCellViewModel(
                    targetDate: Date(timeIntervalSince1970: TimeInterval(event.startTime)),
                    info: event.name,
                    isFavorite: false
                )
                
                sportsTableViewSectionContentViewModels.append(sportsTableViewSectionContentViewModel)
            }
            
            sportsTableViewSectionContentViewModels.sort(by: { $0.targetDate < $1.targetDate })
            
            let sportsTableViewSectionViewModel = SportsTableViewSectionViewModel(
                sportImageName: sport.iconName,
                title: sport.name,
                isCollapsed: false,
                content: sportsTableViewSectionContentViewModels
            )
            
            sportsTableViewModel.append(sportsTableViewSectionViewModel)
        }
    }
    
    private func applyState(_ viewState: ViewState) {
        switch viewState {
        case .success:
            stopLoading()
            
            guard previousState != .success else {
                self.previousState = self.currentState
                self.currentState = viewState
                return
            }
            
            if previousState == .error {
                hideError()
            }
            
            showContent()
            
        case .error:
            stopLoading()
            
            guard previousState != .error else {
                self.previousState = self.currentState
                self.currentState = viewState
                return
            }
            
            if previousState == .success {
                hideContent()
            }
            
            showError()
            
        case .loading:
            startLoading()
        }
        
        self.previousState = self.currentState
        self.currentState = viewState
    }
    
    private func showContent() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            sportsTableView.alpha = 0
            view.addSubview(sportsTableView)
            
            NSLayoutConstraint.activate([
                sportsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                sportsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                sportsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                sportsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
            
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.sportsTableView.alpha = 1.0
                self?.sportsTableView.reloadData()
            }
        }
    }
    
    private func hideContent() {
        DispatchQueue.main.async { [weak self] in
            guard let sportsTableView = self?.sportsTableView, sportsTableView.superview != nil else {
                return
            }
            
            UIView.animate(
                withDuration: 0.3,
                animations: { [weak self] in
                    self?.sportsTableView.alpha = 0
                },
                completion: { [weak self] _ in
                    self?.sportsTableView.removeFromSuperview()
                }
            )
        }
    }
    
    private func startLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            loadingView.alpha = 0
            loadingView.startLoading()
            view.addSubview(loadingView)
            
            NSLayoutConstraint.activate([
                loadingView.widthAnchor.constraint(equalToConstant: Size.s100.rawValue),
                loadingView.heightAnchor.constraint(equalToConstant: Size.s100.rawValue),
                loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
            
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.loadingView.alpha = 1.0
            }
        }
    }
    
    private func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let loadingView = self?.loadingView, loadingView.superview != nil else {
                return
            }
            
            UIView.animate(
                withDuration: 0.3,
                animations: { [weak self] in
                    self?.loadingView.alpha = 0
                },
                completion: { [weak self] _ in
                    self?.loadingView.stopLoading()
                    self?.loadingView.removeFromSuperview()
                }
            )
        }
    }
    
    private func showError() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            errorView.alpha = 0
            view.addSubview(errorView)
            
            NSLayoutConstraint.activate([
                errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
            
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.errorView.alpha = 1.0
            }
        }
    }
    
    private func hideError() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            guard errorView.superview != nil else {
                return
            }
            
            UIView.animate(
                withDuration: 0.3,
                animations: { [weak self] in
                    self?.errorView.alpha = 0
                },
                completion: { [weak self] _ in
                    self?.loadingView.stopLoading()
                    self?.loadingView.removeFromSuperview()
                }
            )
        }
    }
}

// MARK: - Network
extension SportsDashboard {
    private func getSports(_ completion: @escaping (Bool) -> Void) {
        SportsAPI().getSports { [weak self] success, error, sports in
            
            guard success else {
                print("Error getting sports: \(String(describing: error))")
                completion(false)
                return
            }
            
            self?.sports = sports
            completion(true)
        }
    }
}

// MARK: - UITableViewDatasource, SportsTableViewHeaderViewDelegate & UITableViewDelegate
extension SportsDashboard: UITableViewDataSource, SportsTableViewHeaderViewDelegate, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sportsTableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionViewModel = self.sportsTableViewModel[safe: section] else {
            return nil
        }
        
        let headerView = SportsTableViewHeaderView()
        headerView.delegate = self
        headerView.configure(sectionViewModel: sectionViewModel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sportsTableViewModel[safe: section]?.isCollapsed == true ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let eventCellViewModels = self.sportsTableViewModel[safe: indexPath.section]?.content else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SportsTableViewCell.cellIdentifier
        ) as? SportsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(eventCellViewModels: eventCellViewModels)
        cell.eventCollectionViewCellDelegate = self
        return cell
    }
    
    func didTapHeaderView(isSelected: Bool, id: UUID?) {
        guard let sectionID = id, let sectionIndex = self.sportsTableViewModel.firstIndex(where: { $0.id == sectionID }) else {
            print("Missing section view model to \(isSelected ? "collapse" : "expand")")
            return
        }
        
        guard isSelected else {
            self.sportsTableViewModel[sectionIndex].isCollapsed = false
            sportsTableView.insertRows(at: [IndexPath(row: 0, section: sectionIndex)], with: .fade)
            return
        }
        
        self.sportsTableViewModel[sectionIndex].isCollapsed = true
        sportsTableView.deleteRows(at: [IndexPath(row: 0, section: sectionIndex)], with: .fade)
    }
}

// MARK: - EventCollectionViewCellDelegate
extension SportsDashboard: EventCollectionViewCellDelegate {
    func favoriteButtonTapped(favorite: Bool, id: UUID?) {
        
        guard let eventCellID = id, 
              let sportsTableViewSectionViewModelIndex = sportsTableViewModel.firstIndex(where: { $0.content.contains(where: { $0.id == eventCellID })}),
              var mutableSportsTableViewSectionViewModel = self.sportsTableViewModel[safe: sportsTableViewSectionViewModelIndex]  else {
            return
        }
        
        mutableSportsTableViewSectionViewModel.updateContentFavoriteWithID(eventCellID, favorite: favorite)
        var mutableSportsTableViewModel = self.sportsTableViewModel
        mutableSportsTableViewModel[sportsTableViewSectionViewModelIndex] = mutableSportsTableViewSectionViewModel
        self.sportsTableViewModel = mutableSportsTableViewModel
        
        self.sportsTableView.reloadSections(IndexSet(integer: sportsTableViewSectionViewModelIndex), with: .fade)
    }
}

// MARK: - ErrorViewDelegate
extension SportsDashboard: ErrorViewDelegate {
    func didPressTryAgainButton() {
        getSports()
    }
}
