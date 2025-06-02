//
//  ViewController.swift
//  TestBaseMessageList
//
//  Created by Behruz Norov on 31/05/25.
//

import UIKit

final class ChatViewController: UIViewController {

    private let viewModel = ChatViewModel()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.loadMessages()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.safeAreaLayoutGuide.layoutFrame
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: { _ in
            self.collectionView.reloadData()
        })
    }

    private func setupUI() {
        title = "Chat"
        view.backgroundColor = .white

        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.identifier)
        collectionView.transform = CGAffineTransform(scaleX: 1, y: -1)
        view.addSubview(collectionView)
    }
}

// MARK: - UICollectionViewDataSource

extension ChatViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfMessages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MessageCell.identifier,
            for: indexPath
        ) as? MessageCell else {
            return UICollectionViewCell()
        }
        
        guard let message = viewModel.message(at: indexPath.item) else {
            return cell
        }
        
        let time = viewModel.formattedTime(for: message)
        let containerWidth = collectionView.bounds.width
        
        cell.configure(
            with: message,
            time: time,
            containerWidth: containerWidth
        )
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        guard let message = viewModel.message(at: indexPath.item) else {
            return CGSize(width: collectionView.bounds.width, height: CollectionViewConstants.defaultCellHeight)
        }
        
        let time = viewModel.formattedTime(for: message)
        let containerWidth = collectionView.bounds.width
        let height = MessageCell.height(
            for: message,
            containerWidth: containerWidth,
            time: time
        )
        
        return CGSize(width: containerWidth, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return CollectionViewConstants.messageSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return CollectionViewConstants.messageSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return CollectionViewConstants.sectionInsets
    }
}
