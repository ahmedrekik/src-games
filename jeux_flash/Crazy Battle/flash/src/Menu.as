package {		import flash.display.Sprite;	import flash.events.MouseEvent;		import jeu.GestionJeu;	/**	 * @author Aymeric	 */	public class Menu extends Sprite {				private var conteneurMenu:Sprite=new Sprite();				public function Menu():void {						addChild(conteneurMenu);			jouer();		}				private function jouer():void {						var maGestionJeu : GestionJeu = new GestionJeu;			conteneurMenu.addChild(maGestionJeu);			}				private function viderConteneurMenu():void {						while (conteneurMenu.numChildren>0) {				conteneurMenu.removeChildAt(0);			}		}	}}