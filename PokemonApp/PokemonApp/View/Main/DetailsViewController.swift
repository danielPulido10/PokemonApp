//
//  DetailsViewController.swift
//  PokemonApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 8/09/22.
//

import UIKit

class DetailsViewController: BaseViewController {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var descriptionPokemonLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var abilityTitleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var abilitiesCollectionView: UICollectionView!
    
    var namePokemon:String?
    var urlImage:String?
    var arrayAbilities:Array<Abilities>? = Array<Abilities>()
    var arrayMoves:Array<Moves>? = Array<Moves>()
    
    private var viewModelDetails = ViewModelDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        abilitiesCollectionView.dataSource = self
        abilitiesCollectionView.register(UINib(nibName: "AbilityCollectionCell", bundle: nil), forCellWithReuseIdentifier: "abilityCell")
        
        viewModelDetails.GetAbilities(arrayAbilities: arrayAbilities!)
        SetupViews()
        bind()
    }
    
    private func bind (){
        viewModelDetails.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.abilitiesCollectionView.reloadData()
            }
        }
    }
    
    private func SetupViews(){
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: containerView.frame.width, height: 20000)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false;
        
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.font = UIFont(name: "Pokemon Solid", size: 26)
        pokemonNameLabel.textAlignment = .center
        pokemonNameLabel.numberOfLines = 0
        pokemonNameLabel.textColor = .white
        pokemonNameLabel.text = namePokemon
        
        let imageData:NSData = NSData(contentsOf: URL(string: urlImage!)!)!
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        pokemonImage.layer.cornerRadius = 20;
        pokemonImage.backgroundColor = Colors.grayDark
        pokemonImage.image = UIImage(data: imageData as Data)
        
        descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
        descriptionTitleLabel.textColor = Colors.yellow
        descriptionTitleLabel.textAlignment = .left
        descriptionTitleLabel.numberOfLines = 0
        descriptionTitleLabel.text = "Descripción"
        
        descriptionPokemonLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionPokemonLabel.textColor = Colors.blueCold
        descriptionPokemonLabel.textAlignment = .left
        descriptionPokemonLabel.numberOfLines = 0
        
        if arrayMoves?.count == 0{
            descriptionPokemonLabel.text = "Este pokemon no cuenta con ningun movimiento registrado por el momento."
        }else if arrayMoves!.count > 3{
            descriptionPokemonLabel.text = "Este pokemon cuenta con \(arrayMoves!.count) movimientos, algunos de ellos son \(arrayMoves![0].move!.name!), \(arrayMoves![1].move!.name!), \(arrayMoves![2].move!.name!)"
        }else{
            descriptionPokemonLabel.text = "Este pokemon cuenta con \(arrayMoves!.count) movimientos, uno de ellos es \(arrayMoves![0].move!.name!)"
        }
        
        abilityTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        abilityTitleLabel.textColor = Colors.yellow
        abilityTitleLabel.textAlignment = .left
        abilityTitleLabel.numberOfLines = 0
        abilityTitleLabel.text = "Habilidades"
        
        abilitiesCollectionView.translatesAutoresizingMaskIntoConstraints = false;
        abilitiesCollectionView.backgroundColor = Colors.dark
        abilitiesCollectionView.layer.cornerRadius = 20
        
        SetConstraints()
    }
    
    private func SetConstraints(){
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            pokemonNameLabel.centerYAnchor.constraint(equalTo: pokemonImage.centerYAnchor),
            pokemonNameLabel.leftAnchor.constraint(equalTo: pokemonImage.rightAnchor, constant: 10),
            pokemonNameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor, constant: 30),
            pokemonImage.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30),
            pokemonImage.rightAnchor.constraint(equalTo: pokemonNameLabel.leftAnchor, constant: 10),
            pokemonImage.widthAnchor.constraint(equalToConstant: 150),
            pokemonImage.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTitleLabel.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: 40),
            descriptionTitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30),
            descriptionTitleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            descriptionPokemonLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 15),
            descriptionPokemonLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30),
            descriptionPokemonLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            abilityTitleLabel.topAnchor.constraint(equalTo: descriptionPokemonLabel.bottomAnchor, constant: 30),
            abilityTitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30),
            abilityTitleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            abilitiesCollectionView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            abilitiesCollectionView.topAnchor.constraint(equalTo: abilityTitleLabel.bottomAnchor, constant: 20),
            abilitiesCollectionView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            abilitiesCollectionView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            abilitiesCollectionView.widthAnchor.constraint(equalToConstant: containerView.frame.width - 20),
            abilitiesCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
    }
}

extension DetailsViewController : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelDetails.arrayAbilities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = abilitiesCollectionView.dequeueReusableCell(withReuseIdentifier: "abilityCell", for: indexPath) as? AbilityCollectionCell
        cell?.titleLabel.text = viewModelDetails.arrayAbilities[indexPath.row].name
        cell?.descriptionLabel.text = viewModelDetails.arrayAbilities[indexPath.row].effect_entries[0].effect
        return cell!
    }
}
