//
//  ViewController.swift
//  Quotes
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var quotes = [Quote](){
        didSet{
            updateView()
        }
    }
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Quote> = {
        
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Quote> = Quote.fetchRequest()

        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]

        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)

        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()
    
    private let persistentContainer = NSPersistentContainer(name: "Quotes")
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    //MARK: Helper functions
    
    private func updateView(){
        var hasQuotes = false

        if let quotes = fetchedResultsController.fetchedObjects {
            hasQuotes = quotes.count > 0
        }

        tableView.isHidden = !hasQuotes
        messageLabel.isHidden = hasQuotes

        activityIndicatorView.stopAnimating()
    }
    
    private func setupView() {
        setupMessageLabel()

        updateView()
    }

    private func setupMessageLabel() {
        messageLabel.text = "You don't have any quotes yet."
    }
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")

            } else {
                self.setupView()

                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }

                self.updateView()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let quotes = fetchedResultsController.fetchedObjects else { return 0 }
        return quotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.reuseIdentifier, for: indexPath) as? QuoteTableViewCell else {
            fatalError("Unexpected Index Path")
        }

        // Fetch Quote
        let quote = fetchedResultsController.object(at: indexPath)

        // Configure Cell
        cell.authorLabel.text = quote.author
        cell.contentsLabel.text = quote.contents

        return cell
    }
    
}

extension ViewController: NSFetchedResultsControllerDelegate {}
