﻿package jeu {		import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;	import jeu.bases.Alien;	import jeu.personnages.monsters.Momie;	import jeu.personnages.aliens.Blop;	/**	 * @author Aymeric	 */	public class GestionJeu extends Sprite {				private var conteneurJeu : Sprite=new Sprite();				private var laBaseAlien : Alien = new Alien();				private var tabAliens : Array = new Array();		private var tabMonsters : Array = new Array();				private var maCreationPerso:Sprite=new creerPerso();		private var nbrAliens : uint=0;		private var nbrMonsters : uint=0;				private var nbrAliensKilled:uint=0;		private var nbrMonstersKilled:uint=0;		private var maMomie : Momie;		private var monBlop : Blop;				private var degatSubit:int;				public function GestionJeu():void {						addChild(conteneurJeu);			conteneurJeu.addChild(laBaseAlien);						creerMomie();						laBaseAlien.addEventListener("perdu", fin, false, 0, true);			conteneurJeu.addEventListener(Event.ENTER_FRAME, conflit, false, 0, true);						addChild(maCreationPerso);			maCreationPerso.addEventListener(MouseEvent.MOUSE_DOWN, essai, false, 0, false);		}				private function essai(m : MouseEvent):void {			maMomie = new Momie();			conteneurJeu.addChild(maMomie);			tabMonsters.push(maMomie);			maMomie.name=String(nbrMonsters++);						monBlop = new Blop();			conteneurJeu.addChild(monBlop);			tabAliens.push(monBlop);			monBlop.name=String(nbrAliens++);		}		private function creerMomie():void {						/*maMomie = new Momie();			conteneurJeu.addChild(maMomie);			tabMonsters.push(maMomie);						monBlop = new Blop();			conteneurJeu.addChild(monBlop);			tabAliens.push(monBlop);*/		}		private function conflit(e:Event):void {						for (var i:uint=0; i<tabMonsters.length; i++) {				for (var j:uint=0; j<tabAliens.length; j++) {										//Combats Base :					/*if ((tabMonsters[i] as Momie).hitTestObject(laBaseAlien)) {						momieVSbase();					}*/										//Combats Créature :					if (((tabMonsters[i] as Momie).hitTestObject(tabAliens[j] as Blop)) && ((tabAliens[j] as Blop).hitTestObject(tabMonsters[i] as Momie))) {						blopVSmomie();						momieVSblop();					}				}			}		}				private function momieVSbase():void {			degatSubit = maMomie.force;			laBaseAlien.baseAttaquee(degatSubit);			maMomie.attaqueBase();						if ((laBaseAlien.baseAttaquee(degatSubit))==true) {				maMomie.victoire();				trace("base alien détruite");			}		}		private function momieVSblop():void {			degatSubit = monBlop.force;			maMomie.combat(degatSubit);						if ((maMomie.combat(degatSubit))==true) {				monBlop.victoire();				nbrMonstersKilled++;				tabMonsters.shift();				trace("la momie est morte");			}		}		private function blopVSmomie():void {			degatSubit = maMomie.force;			monBlop.combat(degatSubit);						if ((monBlop.combat(degatSubit))==true) {				maMomie.victoire();				nbrAliensKilled++;				tabAliens.shift();				trace("le blop est mort");			}		}				private function fin(e:Event):void {			trace("les monstres ont gagné")		}	}}