/** * Tutoriel "Les jeux à base de tuiles * "http://ressources.mediabox.fr/tutoriaux/flashplatform/jeux/jeux_a_base_de_tuiles" *  * Classe "Jeu" * */package kinessia.pacman {	import kinessia.pacman.objects.EndLevel;	import kinessia.pacman.objects.Heros;	import kinessia.pacman.objects.Sol;	import flash.display.Sprite;	/**	 * On hérite de la classe Sprite, on doit donc l'importer avant tout.	 */		/**	 * On importe les Objets.	 */ 	/**	 * On déclare la classe Jeu, héritière de la classe Sprite.	 */	public class Pacman extends Sprite	{				/**		 * Déclaration du héros.		 */		private var _heros:Heros;				/**		 * Déclaration de la carte du niveau.		 */		private var _plan:Array = [ [ 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9 ],									[ 9, 1, 0, 9, 1, 9, 0, 0, 9, 9, 9, 9, 9, 9, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9 ],									[ 9, 1, 9, 9, 1, 9, 1, 9, 0, 0, 0, 9, 9, 9, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9 ],									[ 9, 1, 9, 9, 1, 9, 1, 9, 9, 9, 1, 9, 9, 9, 9, 0, 9, 9, 1, 8, 9, 9, 9, 9 ],									[ 9, 0, 0, 0, 0, 9, 0, 0, 9, 9, 1, 9, 9, 9, 9, 0, 9, 9, 1, 9, 9, 9, 9, 9 ],									[ 9, 9, 9, 1, 1, 9, 9, 1, 9, 9, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 9, 9, 9, 9 ],									[ 9, 0, 9, 1, 9, 9, 9, 1, 9, 9, 9, 1, 9, 9, 9, 9, 0, 9, 9, 1, 9, 9, 9, 9 ],									[ 9, 0, 0, 2, 0, 0, 9, 1, 0, 0, 0, 0, 9, 9, 9, 9, 0, 9, 9, 1, 9, 9, 9, 9 ],									[ 9, 0, 9, 1, 9, 9, 9, 1, 9, 1, 9, 1, 1, 9, 9, 0, 0, 9, 9, 1, 9, 9, 9, 9 ],									[ 9, 9, 9, 1, 0, 0, 9, 9, 9, 1, 9, 9, 1, 9, 0, 0, 9, 9, 9, 0, 0, 0, 0, 9 ],									[ 9, 9, 9, 9, 9, 1, 9, 1, 0, 0, 0, 9, 1, 9, 0, 9, 9, 9, 9, 9, 1, 9, 0, 9 ],									[ 9, 9, 9, 0, 0, 0, 0, 0, 9, 9, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 1, 9, 0, 9 ],									[ 9, 9, 9, 0, 9, 9, 9, 1, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 9 ],									[ 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9 ] ]; 		/**		 * Carte du jeu		*/		private var _carte:Carte = new Carte ( _plan[0].length + 1, _plan.length + 1, 25, 25 );				/**		 *  Constructor		 */ 		public function Pacman ( )		{			/**			 * On instantie le héros.			 */			_heros = new Heros ();						/**			 * On enregistre le nombre de lignes de la carte.			 */			var max_j:int = _plan.length;						/**			 * On enregistre la longueur d'une ligne de la carte.			 */			var max_i:int = _plan[0].length;						/**			 * On fait une boucle qui agit sur toutes les lignes de la carte.			 */			for ( var i:int = 0; i < max_i; i++ )			{				/**				 * Dans laquelle la seconde boucle agit sur chaque tuile,				 * de la ligne en cours.				 */				for ( var j:int = 0; j < max_j; j++ )				{					/**					 * On utilise un switch pour ajouter un Mur ou un Sol en fonction de la valeur					 * indiquée dans la variable _plan, dans la case en cours.					 */					switch ( _plan [j][i] )					{						case 0 : //Si c'est 0, on ajoute un Sol							_carte.ajouter ( new Sol(), i, j );							break;						case 1 : 							_carte.ajouter ( new Sol(), i, j );							break;						case 2 : 							_carte.ajouter ( new Sol(), i, j );							break;						case 8 :							_carte.ajouter( new EndLevel(), i, j);							break;						default :							break;					}				}			}						/**			 * On ajoute le héros à la carte.			 */			_carte.ajouter ( _heros, 1, 1 );						/**			 * On ajoute la carte à la liste d'affichage pour la rendre visible.			 */			addChild ( _carte );		}				public function destroy():void {						_heros.dispose();			delete this;		}	}}