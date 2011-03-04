package pages {	import pages.decor.DecorEvent;	import pages.decor.enceinte.Enceinte;	import pages.decor.platine.Platine;	import pages.decor.robot.ARobot;	import pages.ia.IAEvent;	import pages.ia.Joueur;	import pages.ia.Machine;	import pages.son.PlaylistSon;	import com.gaiaframework.api.Gaia;	import com.gaiaframework.templates.AbstractPage;	import com.greensock.TweenMax;	import flash.events.Event;	import flash.events.TimerEvent;	import flash.utils.Timer;	public class JeuPage extends AbstractPage {		public var enceinte:Enceinte;		public var platine:Platine;		public var robot:ARobot;		private var _machine:Machine;		private var _joueur:Joueur;		private var _nbSon:uint;		private var _timer:Timer;		private var _timerAToi:Timer;		private var _timerAttenteJoueur:Timer;		public function JeuPage() {			super();			alpha = 0;			new Scaffold(this);		}		override public function transitionIn():void {			super.transitionIn();			TweenMax.to(this, 0.3, {alpha:1, onComplete:transitionInComplete});			_initGame();		}		private function _initGame():void {			PlaylistSon.init();			enceinte.init();			platine.init();			_machine = new Machine();			_joueur = new Joueur(stage);			_joueur.addEventListener(DecorEvent.ENCEINTE_ONDE, _enceinte);			_joueur.addEventListener(IAEvent.SCORE_SEQUENCE_REUSSIE, _updateScore);			_joueur.addEventListener(IAEvent.SCORE_SON_REUSSI, _updateScore);			_joueur.addEventListener(IAEvent.SCORE_SON_ERREUR, _updateScore);			robot.initMachine();			_timer = new Timer(1000, 1);			_timerAToi = new Timer(1500, 1);			_timerAttenteJoueur = new Timer(4800, 1);			_timer.start();			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _preLancerBattle);		}		private function _preLancerBattle(tEvt:TimerEvent):void {			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _preLancerBattle);			_timer = null;			_lancerBattle();		}		private function _lancerBattle(evt:Event = null):void {			_autoriserJouerJouer(false);			_joueur.autoriserJouerJouer(false);			_joueur.removeEventListener(IAEvent.JOUEUR_COMPLETE, _lancerBattle);			_joueur.removeEventListener(IAEvent.JOUEUR_FAIL, _finJeu);			if (evt != null && evt.type == "JOUEUR_SEQUENCE_ECHEC") {				_machine.definirSequence(_nbSon);			} else {				_machine.definirSequence(++_nbSon);				if (evt != null && evt.type == "JOUEUR_COMPLETE") {					if (_nbSon - 1 == 5) {						robot.degradation(1);						enceinte.augmenterVolume(2);						enceinte.reussite(1);						PlaylistSon.getSoundGroup().volume = 2;						PlaylistSon.getMySound("applaudissement").play();					} else if (_nbSon - 1 == 10) {						robot.degradation(2);						enceinte.augmenterVolume(5);						enceinte.reussite(2);						PlaylistSon.getSoundGroup().volume = 5;						PlaylistSon.getMySound("applaudissement").play();					}				}			}			_machine.addEventListener(DecorEvent.MACHINE_SON1, _machineAnimation);			_machine.addEventListener(DecorEvent.MACHINE_SON2, _machineAnimation);			_machine.addEventListener(DecorEvent.MACHINE_SON3, _machineAnimation);			_machine.addEventListener(DecorEvent.MACHINE_SON4, _machineAnimation);			_machine.addEventListener(DecorEvent.MACHINE_A_TOI, _machineAnimation);			_machine.addEventListener(IAEvent.MACHINE_COMPLETE, _reproduireSeqPourJoueurTimer);		}		private function _reproduireSeqPourJoueurTimer(event:IAEvent):void {			_timerAttenteJoueur.start();			_timerAttenteJoueur.addEventListener(TimerEvent.TIMER_COMPLETE, _reproduireSeqPourJoueur);		}		private function _reproduireSeqPourJoueur(event:Event):void {			_autoriserJouerJouer(true);			_joueur.autoriserJouerJouer(true);			_machine.removeEventListener(IAEvent.MACHINE_COMPLETE, _reproduireSeqPourJoueur);			_timerAttenteJoueur.removeEventListener(TimerEvent.TIMER_COMPLETE, _reproduireSeqPourJoueurTimer);			robot.attendre();			_joueur.reproduireSequence(_nbSon);			_joueur.addEventListener(IAEvent.JOUEUR_COMPLETE, _lancerBattle);			_joueur.addEventListener(IAEvent.JOUEUR_SEQUENCE_ECHEC, _recommenceSeq);			_joueur.addEventListener(IAEvent.JOUEUR_FAIL, _finJeu);			_joueur.addEventListener(IAEvent.JOUEUR_WIN, _finJeu);		}		private function _recommenceSeq(iaEvt:IAEvent):void {			_joueur.removeEventListener(IAEvent.JOUEUR_COMPLETE, _lancerBattle);			_joueur.removeEventListener(IAEvent.JOUEUR_SEQUENCE_ECHEC, _recommenceSeq);			_joueur.removeEventListener(IAEvent.JOUEUR_FAIL, _finJeu);			_joueur.removeEventListener(IAEvent.JOUEUR_WIN, _finJeu);			_lancerBattle(iaEvt);		}		private function _finJeu(iaEvt:IAEvent):void {			_joueur.removeEventListener(IAEvent.JOUEUR_COMPLETE, _lancerBattle);			_joueur.removeEventListener(IAEvent.JOUEUR_SEQUENCE_ECHEC, _recommenceSeq);			_joueur.removeEventListener(IAEvent.JOUEUR_FAIL, _finJeu);			_joueur.removeEventListener(IAEvent.JOUEUR_WIN, _finJeu);			switch (iaEvt.type) {				case "JOUEUR_FAIL":					robot.gagne();					enceinte.echec();					trace('YOU LOSE ! score : ' + platine.getScore());					break;				case "JOUEUR_WIN":					robot.perd();					enceinte.reussite(2);					enceinte.onde();					trace('YOU WIN ! score : ' + platine.getScore());					break;			}			Gaia.api.getPage(Pages.INDEX).content.scoreDefini = true;			Gaia.api.getPage(Pages.INDEX).content.score = platine.getScore();		}		private function _updateScore(iaEvt:IAEvent):void {			switch (iaEvt.type) {				case "SCORE_SON_ERREUR":					robot.moquer();					enceinte.echec();					PlaylistSon.getMySound("moquer").play();					_timer = new Timer(1000, 1);					_timer.start();					_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _relancerMouvementContinuRobot);					break;			}			platine.ajoutScore(iaEvt.addScore);		}		private function _machineAnimation(dEvt:DecorEvent):void {			if (dEvt.type == "MACHINE_A_TOI") {				_timerAToi.start();				_timerAToi.addEventListener(TimerEvent.TIMER_COMPLETE, _robotJouerSon);			} else {				robot.jouerSon(dEvt.type);			}		}		private function _robotJouerSon(tEvt:TimerEvent):void {			_timerAToi.removeEventListener(TimerEvent.TIMER_COMPLETE, _robotJouerSon);			robot.jouerSon("MACHINE_A_TOI");		}		private function _animPerso(dEvt:DecorEvent):void {			platine.animPerso(dEvt.type);		}		private function _relancerMouvementContinuRobot(tEvt:TimerEvent):void {			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _relancerMouvementContinuRobot);			_timer = null;			robot.attendre();		}		private function _autoriserJouerJouer($value:Boolean):void {			if ($value == true) {				_joueur.addEventListener(DecorEvent.DISQUE_BAS, _animPerso);				_joueur.addEventListener(DecorEvent.DISQUE_HAUT, _animPerso);				_joueur.addEventListener(DecorEvent.FADER_SCRASH_BAS, _animPerso);				_joueur.addEventListener(DecorEvent.FADER_SCRASH_HAUT, _animPerso);			} else {				_joueur.removeEventListener(DecorEvent.DISQUE_BAS, _animPerso);				_joueur.removeEventListener(DecorEvent.DISQUE_HAUT, _animPerso);				_joueur.removeEventListener(DecorEvent.FADER_SCRASH_BAS, _animPerso);				_joueur.removeEventListener(DecorEvent.FADER_SCRASH_HAUT, _animPerso);			}		}		private function _enceinte(dEvt:DecorEvent):void {			enceinte.onde();		}		override public function transitionOut():void {			super.transitionOut();			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});		}	}}