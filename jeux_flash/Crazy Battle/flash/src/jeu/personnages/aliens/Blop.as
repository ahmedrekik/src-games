﻿package jeu.personnages.aliens {		import flash.display.MovieClip;		import flash.display.Sprite;	import flash.events.Event;	/**	 * @author Aymeric	 */	public class Blop extends Sprite {				public const force : int=10;				private const vitesse:int=-10;				private var monPersoBlop : MovieClip = new PersoBlop();				private var vie : int=200;		private var mort : Boolean=false;		private var arretMouvement:Boolean=false;		public function Blop():void {						addChild(monPersoBlop);			monPersoBlop.scaleX=0.05;			monPersoBlop.scaleY=0.05;			monPersoBlop.x=1000;			monPersoBlop.y=400;						monPersoBlop.addEventListener(Event.ENTER_FRAME, deplacementBlop, false, 0, true);		}				public function attaqueBase():void {						monPersoBlop.removeEventListener(Event.ENTER_FRAME, deplacementBlop);						if (arretMouvement==false) {				monPersoBlop.stop();				arretMouvement=true;			}		}				public function combat(degatSubit:int):Boolean {						monPersoBlop.removeEventListener(Event.ENTER_FRAME, deplacementBlop);						if (arretMouvement==false) {				monPersoBlop.gotoAndPlay(30);				arretMouvement=true;			}						vie=vie-degatSubit;						if (vie<1) {				removeChild(monPersoBlop);				mort=true;			}						return mort;		}				public function victoire():void {						monPersoBlop.gotoAndPlay(0);			monPersoBlop.addEventListener(Event.ENTER_FRAME, deplacementBlop, false, 0, true);			arretMouvement=false;		}		private function deplacementBlop(e:Event):void {						if (vie>1) {				monPersoBlop.x+=vitesse;								if (monPersoBlop.x<0) {					monPersoBlop.removeEventListener(Event.ENTER_FRAME, deplacementBlop);					removeChild(monPersoBlop);				}			}		}	}}