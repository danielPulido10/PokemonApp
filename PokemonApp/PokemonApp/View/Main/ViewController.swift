//
//  ViewController.swift
//  PokemonApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 6/09/22.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var changeButton: UIButton!
    
    private var viewModelCollection = ViewModelCollection.shared
    
    var indexP:[IndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "oneColumnCell")
        CollectionView.register(UINib(nibName: "CollectionTwoViewCell", bundle: nil), forCellWithReuseIdentifier: "twoColumnCell")
        
        CollectionView.isHidden = true
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        indicatorView.color = Colors.yellow
        
        viewModelCollection.GetPokemons(first: 1, last: 20)
        SetupViews()
        bind()
    }
    
    private func bind (){
        viewModelCollection.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.CollectionView.reloadData()
            }
        }
        self.indicatorView.isHidden = true
        self.indicatorView.stopAnimating()
        self.CollectionView.isHidden = false
    }
    
    private func SetupViews(){
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Toda la información de tu pokemon favorito en una sola App"
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = Colors.blueCold
        descriptionLabel.numberOfLines = 0
        
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        changeButton.tintColor = Colors.dark
        changeButton.setTitle(viewModelCollection.nameButton, for: .normal)
        changeButton.backgroundColor  = colors.yellow
        changeButton.layer.cornerRadius = 10
        
        CollectionView.translatesAutoresizingMaskIntoConstraints = false
        CollectionView.backgroundColor = Colors.dark
        CollectionView.layer.cornerRadius = 20
        
        SetConstraints()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        viewModelCollection.ChangeCell()
        CollectionView.reloadData()
        changeButton.setTitle(viewModelCollection.nameButton, for: .normal)
    }
    
    private func SetConstraints(){
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            changeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            changeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            changeButton.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            CollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CollectionView.topAnchor.constraint(equalTo: changeButton.layoutMarginsGuide.bottomAnchor, constant: 20),
            CollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
            CollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -170),
        ])
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicatorView.topAnchor.constraint(equalTo: view.bottomAnchor),
            indicatorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            indicatorView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "VCDetails"{
            if let viewController = segue.destination as? DetailsViewController{
                if let index = sender as? Int{
                    viewController.namePokemon = viewModelCollection.arrayPokemon[index].name
                    viewController.urlImage = viewModelCollection.arrayPokemon[index].sprites?.front_default
                    viewController.arrayAbilities = viewModelCollection.arrayPokemon[index].abilities
                    viewController.arrayMoves = viewModelCollection.arrayPokemon[index].moves
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelCollection.arrayPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModelCollection.dividerCell == 2{
            let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "twoColumnCell", for: indexPath) as? TwoColumnCell
            cell!.namePokemonLabel.text = viewModelCollection.arrayPokemon[indexPath.row].name
            let imageData:NSData = NSData(contentsOf: URL(string: (viewModelCollection.arrayPokemon[indexPath.row].sprites?.front_default)!)!)!
            cell!.pokemonImageView.image = UIImage(data: imageData as Data)
            indexP.append(indexPath)
            return cell!
        }else{
            let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "oneColumnCell", for: indexPath) as? OneColumnCell
            cell!.namePokemonLabel.text = viewModelCollection.arrayPokemon[indexPath.row].name
            let imageData:NSData = NSData(contentsOf: URL(string: (viewModelCollection.arrayPokemon[indexPath.row].sprites?.front_default)!)!)!
            cell!.pokemonImageView.image = UIImage(data: imageData as Data)
            indexP.append(indexPath)
            return cell!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "VCDetails", sender: indexPath.row)
    }
}
