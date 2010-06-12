package lo43.projet.utboheme.jeu;

import java.awt.Color;
import java.util.ArrayList;
import java.util.List;

import lo43.projet.utboheme.arbre.ArbreBinaire;
import lo43.projet.utboheme.carte.GroupeCartes;
import lo43.projet.utboheme.carte.GroupeCartesDev;
import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.pion.Pion;
import lo43.projet.utboheme.pion.UV;

/**
 * Classe repr市entant un joueur
 * 	- poss重e un identifiant
 *  - poss重e un nom
 *  - poss重e une couleur
 *  - poss重e un nombre de point de victoire
 *  - poss重e un attribut pour rep屍er s'il poss重e ancien plus vieu
 *  - poss重e un attribut pour rep屍er s'il poss重e cursus plus long
 *  - poss重e un attribut pour savoir s'il est actif
 *  - poss重e une liste de groupe de cartes (ressource et d思eloppement)
 *  - poss重e une liste de groupe de cartes de developpement d史� jou仔s
 *  - poss重e une liste de contr冤e continu 
 *  - poss重e une liste d'uv
 *  - poss重e une liste d'uv**
 *  - poss重e une liste de chemin pour cursus plus long
 * @author alexandreaugen
 *
 */
public class Joueur {
	
	private int ident;
	private String nom;
	private Color couleur;
	private int nbPoints;
	private boolean ancien;
	private boolean cursus;
	private boolean actif;

	private List<GroupeCartes> lcartes;
	private List<GroupeCartesDev> lcartesJouees;
	private List<Pion> lcc;
	private List<UV> luv;
	private List<UV> luvstar;
	private List<ArbreBinaire> chemins;
	
	/**
	 * Constructeur par d伺aut
	 */
	public Joueur() {
		this.ident = 0;
		this.nom = null;
		this.couleur = null;
		this.nbPoints = 0;
		this.ancien = false;
		this.cursus = false;
		this.actif = false;
		this.lcartes = null;
		this.lcartesJouees = null;
		this.lcc = null;
		this.luv = null;
		this.luvstar = null;
		this.chemins = null;
	}
	
	/**
	 * Constructeur param師r�
	 * @param pident
	 * @param pnom
	 * @param pc
	 */
	public Joueur(Integer pident, String pnom, Color pc) {
		this();
		this.ident = pident;
		this.nom = pnom;
		this.couleur = pc;
		
		//Attribution par d伺aut des diff屍ents groupes de cartes vide
		this.lcartes = new ArrayList<GroupeCartes>();
		lcartes.add(new GroupeCartes(0, TypeCartes.BIERE));
		lcartes.add(new GroupeCartes(0, TypeCartes.SOMMEIL));
		lcartes.add(new GroupeCartes(0, TypeCartes.CAFE));
		lcartes.add(new GroupeCartes(0, TypeCartes.SUPPORT));
		lcartes.add(new GroupeCartes(0, TypeCartes.NOURRITURE));

		this.lcartesJouees = new ArrayList<GroupeCartesDev>();
		this.luvstar = new ArrayList<UV>();
		this.luv = new ArrayList<UV>();
		this.lcc = new ArrayList<Pion>();
		
		//Attribution par d伺aut des diff屍ents pions du joueurs
		for(int i=0; i<4; i++) {
			this.luvstar.add(new UV(this, 2, true));
		}
		for(int i=0; i<5; i++) {
			this.luv.add(new UV(this, 1, false));
		}
		for(int i=0; i<15; i++) {
			this.lcc.add(new Pion(this));
		}
	}

	/**
	 * Renvoi l'identifiant du joueur
	 * @return
	 * 	- un entier
	 */
	public int getIdent() {
		return ident;
	}

	/**
	 * Renvoi le nom du joueur
	 * @return
	 * 	- un string
	 */
	public String getNom() {
		return nom;
	}

	/**
	 * Attribut le param師re au nom au joueur 
	 * @param nom
	 */
	public void setNom(String nom) {
		this.nom = nom;
	}

	/**
	 * Renvoi la couleur associ� au joueur
	 * @return
	 * 	- une couleur
	 */
	public Color getCouleur() {
		return couleur;
	}

	/**
	 * Attribut le param師re � la couleur associ� au joueur
	 * @param c
	 */
	public void setCouleur(Color c) {
		this.couleur = c;
	}

	/**
	 * Renvoi le nombre de points de victoire du joueur
	 * @return
	 * 	- un entier
	 */
	public int getNbPoints() {
		return nbPoints;
	}
	
	/**
	 * M師hode permettant d'ajouter un nombre "nb" au point de victoire du joueur
	 * @param nb
	 */
	public void addNbPoints(int nb) {
		this.nbPoints += nb;
	}

	/**
	 * Test si le joueur poss重e la carte ancien le plus vieu
	 * @return
	 */
	public boolean isAncien() {
		return ancien;
	}

	/**
	 * Attribut ancien le plus vieu au joueur ou enleve
	 * @param ancien
	 */
	public void setAncien(boolean ancien) {
		this.ancien = ancien;
	}

	/**
	 * Test si le joueur poss重e la carte cursus le plus long
	 * @return
	 */
	public boolean isCursus() {
		return cursus;
	}

	/**
	 * Attribut cursus le plus long au joueur ou enleve
	 * @param cursus
	 */
	public void setCursus(boolean cursus) {
		this.cursus = cursus;
	}

	/**
	 * Test si le joueur est actif
	 * @return
	 */
	public boolean isActif() {
		return actif;
	}

	/**
	 * Attribut le joueur comme joueur actif ou non actif
	 * @param actif
	 */
	public void setActif(boolean actif) {
		this.actif = actif;
	}
	
	/**
	 * M師hode permettant de renvoyer un groupe de cartes du stock du joueur selon le type pass� en param師re
	 * @param ptype
	 * @return
	 * 	- un groupe de cartes
	 */
	public GroupeCartes getGroupeCartes(TypeCartes ptype) {
		GroupeCartes resGroupeCartes = new GroupeCartes();
		for(GroupeCartes gc : this.lcartes) {
			if(gc.getTypeCartes() == ptype) {
				resGroupeCartes = gc;
				break;
			}
		}
		return resGroupeCartes;
	}
	
	/**
	 * M師hode permettant d'attribuer un nombre de cartes "nbCartes" au type du groupe de cartes pass� en param師re 
	 * @param ptype
	 * @param nbCartes
	 */
	public void setGroupeCarte(TypeCartes ptype, int nbCartes) {
		this.getGroupeCartes(ptype).addCartes(nbCartes);
	}

	/**
	 * Renvoi la liste des contr冤es continu du joueur
	 * @return
	 * 	- une liste de pions
	 */
	public List<Pion> getLcc() {
		return lcc;
	}
	
	/**
	 * Renvoi la liste des uv du joueur
	 * @return
	 * 	- une liste d'uv
	 */
	public List<UV> getLuv() {
		return luv;
	}

	/**
	 * Renvoi la liste des uv** du joueur
	 * @return
	 * 	- une liste d'uv**
	 */
	public List<UV> getLuvstar() {
		return luvstar;
	}

	/**
	 * Renvoi la nombre d'uv du joueur
	 * @return
	 * 	- un entier
	 */
	public int getNbUV() {
		return luv.size();
	}

	/**
	 * Renvoi le nombre d'uv** du joueur
	 * @return
	 * 	- un entier
	 */
	public int getNbUVStar() {
		return luvstar.size();
	}

	/**
	 * Renvoi le nombre de contr冤e continu du joueur
	 * @return
	 * 	- un entier
	 */
	public int getNbCC() {
		return lcc.size();
	}
	
	/**
	 * Renvoi le nombre des cartes d'un ensemble de groupe de cartes du type pass� en param師re
	 * @param ptype
	 * @return
	 * 	- un entier
	 */
	public int getNbCartes(TypeCartes ptype) {
		return this.getGroupeCartes(ptype).getNombre();
	}

	public List<ArbreBinaire> getChemins() {
		return chemins;
	}

	public void setChemins(List<ArbreBinaire> chemins) {
		this.chemins = chemins;
	}

	/*public boolean construireUV(Sommet sommet, boolean etoile) {
		//phase de fondation ?
		if (nbUV > 3) {
			nbUV--;
			nbPoints++;
		} else {
			if (etoile) { // UV etoilee
				// on dispose des ressources necessaires (2 supports, 3 sommeils)
				if ((cartes.get(4).getNombre() >= 2) && (cartes.get(3).getNombre() >= 3)) {
					if (nbUVStar == 0) {
						//pas de pion !
						return false;
					} else {
						cartes.get(4).remCartes(2);
						cartes.get(3).remCartes(3);
						nbUVStar--;
						nbPoints += 2;
					}
				} else { //pas assez de ressources
					return false;
				}
			} else { //UV simple
				//on dispose des ressources n�ｿｽcessaires (1 biere, 1 nourriture, 1 support, 1 cafe)
				if ((cartes.get(0).getNombre() >= 1) && (cartes.get(1).getNombre() >= 1) && (cartes.get(2).getNombre() >= 1) && (cartes.get(4).getNombre() >= 1)) {
					if (nbUV == 0) {
						//pas de pion
						return false;
					} else {
						cartes.get(0).remCartes(1);
						cartes.get(1).remCartes(1);
						cartes.get(2).remCartes(1);
						cartes.get(4).remCartes(1);
						nbUV--;
						nbPoints++;
					}
				} else { //pas assez de ressources
					return false;
				}
			}
		}
		return true;
	}
	 
	public boolean construireCC(Arete arrete) {
		//phase de fondation ?
		if (nbCC > 13) {
			nbCC--;
			chemins.add(new ArbreBinaire(arrete.getsDebut(), (new ArbreBinaire(arrete.getsFin(), null, null)), null));
		} else {
			// on dispose des ressources necessaires (1 biere, 1 nourriture)
			if ((cartes.get(0).getNombre() >= 1) && (cartes.get(2).getNombre() >= 1)) {
				if (nbCC == 0) {
					//pas de pion !
					return false;
				} else { //on peut construire
					cartes.get(0).remCartes(1);
					cartes.get(2).remCartes(1);
					nbCC--;
					if (!chemins.get(0).ajouterNoeud(arrete.getsDebut(), arrete.getsFin())) {
						if (!chemins.get(1).ajouterNoeud(arrete.getsDebut(), arrete.getsFin())) {
							return false;
						}
					}
				}
			} else { //pas assez de ressources
				return false;
			}
		}
		return true;
	}
	 
	public boolean echange(Joueur joueur, TypeCartes typeDem, int nbDem, TypeCartes typeOff, int nbOff) {
		int inOffre = 0, inDemande = 0; //indices dans les listes pour retrouver le bon type de cartes
		// on recupere les ressources dispos du joueur initiateur de la transaction
		for (int i = 0; i < cartes.size(); i++) {
			if (cartes.get(i).getTypeCartes() == typeOff) {// on trouve le bon type
				if (cartes.get(i).getNombre() >= nbOff) { //on a assez de ressource
					inOffre = i;
				} else {
					return false; //pas assez de ressource
				}
			}
		}
		//on recupere les ressources dispos de l'autre joueur
		for (int i = 0; i < joueur.cartes.size(); i++) {
			if (joueur.cartes.get(i).getTypeCartes() == typeDem) {// on trouve le bon type
				if (joueur.cartes.get(i).getNombre() >= nbDem) { //on a assez de ressource
					inDemande = i;
				} else {
					return false; //pas assez de ressource
				}
			}
		}
		
		//on retire de ses cartes le nombre necessaire et on les ajoute au joueur adverse
		cartes.get(inOffre).remCartes(nbOff);
		joueur.cartes.get(inOffre).addCartes(nbOff);
		//on ajoute a ses cartes les nombre voulu et on les retire du joueur adverse
		cartes.get(inDemande).addCartes(nbDem);
		joueur.cartes.get(inDemande).remCartes(nbDem);
		return true;
	}
	 
	//j'ai fait de la merde
	public boolean troc(TypeCartes matiere, int symbole) {
		// TODO refaire la methode
		for (GroupeCartes grpCartes : cartes) {
			if (grpCartes.getTypeCartes() == matiere) {
				if (grpCartes.getNombre() < symbole) {
					return false;
				} else {
					grpCartes.remCartes(symbole);
					return true;
				}
			}
		}
		return false;
	}
	 
	public GroupeCartes get_cartes(TypeCartes typeCarte) {
		for (GroupeCartes grp : cartes) {
			if (grp.getTypeCartes() == typeCarte) {
				return grp;
			}
		}
		return null;
	}
	 
	public void decouverte(TypeCartes type1, TypeCartes type2) {
		//on ajoute les cartes voulues au stock du joueur warning : il faudra les enlever du stock du jeu
		this.get_cartes(type1).addCartes(1);
		this.get_cartes(type2).addCartes(1);
		this.set_cartesJouees(SousTypeCartes.DECOUVERTE, 1);
	}
	 
	//TODO deplacer la methode monopole dans la classe jeu
	public void monopole(TypeCartes typeRess, int nb) {
		// dans cette classe on ne peut que retirer des cartes du stock du joueur
		this.get_cartes(typeRess).addCartes(nb);
		this.set_cartesJouees(SousTypeCartes.MONOPOLE, 1);
	}
	 
	public boolean volerCarte(Joueur joueur) {
		return false;
	}
	 
	 
	public GroupeCartesDev get_cartesJouees(SousTypeCartes typeCarte) {
		for (GroupeCartesDev dev : cartesJouees) {
			if (dev.getSousTypeCartes() == typeCarte) {
				return dev;
			}
		}
		return null;
	}
	 
	public void set_cartesJouees(SousTypeCartes typeCarte, int nb) {
		for (GroupeCartesDev dev : cartesJouees) {
			if (dev.getSousTypeCartes() == typeCarte) {
				dev.addCartes(nb);
			}
		}
	}
	 
	// TODO definir une methode identique dans Jeu pour les manipulations des cartes de dvpt
	public boolean jouerCartes(SousTypeCartes cartes) {
		return false;
	}
	
	//What is it ?
	public int get_pions(int typePion) {
		return 0;
	}
	 
	//What is it ?
	public boolean acheterCartes() {
		return false;
	}
	
	//n'aurait-elle pas sa place dans Jeu plutot ?
	public boolean deplacerBinomeG(Hexagone HexaInit, Hexagone HexaDest) {
		return false;
	}*/
}
