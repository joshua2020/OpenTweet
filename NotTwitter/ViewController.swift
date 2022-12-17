//
//  ViewController.swift
//  NotTwitter
//
//  Created by Joshua on 11/12/2022.
//

import UIKit

class ViewController: UIViewController, ParalexEffectDelegate {

    let parser = Parser()
    var timeline = [Timeline]()

    @IBOutlet weak var tweetTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        parse()
        tweetTableView.dataSource = self
        tweetTableView.layoutIfNeeded()
        applyParallaxEffect(onView: tweetTableView, magnitude: 20)
    }

    private func parse() {
        parser.parseJson {
            data in
            self.timeline = data
            DispatchQueue.main.async {
            self.tweetTableView.reloadData()
            }
        }
    }

    private func populateCell(cell: TweetTableViewCell?, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cell else { return UITableViewCell() }
        let tweetElement = timeline[indexPath.row]
        cell.setupCell(tweetElement)
        return cell
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timeline.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TweetTableViewCell else { return UITableViewCell() }

     return populateCell(cell: cell, indexPath: indexPath)
    }
}
