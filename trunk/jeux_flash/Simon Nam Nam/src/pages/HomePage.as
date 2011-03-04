package pages {	import com.gaiaframework.api.Gaia;	import com.gaiaframework.templates.AbstractPage;	import com.greensock.TweenMax;	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.events.TimerEvent;	import flash.utils.Timer;	public class HomePage extends AbstractPage {				public var speaker:MovieClip;		public var btn_didac:MovieClip;		public var btn_jouer:MovieClip;		public var btn_score:MovieClip;		public var btn_lancerJeu:MovieClip;		private var _timer:Timer;		public function HomePage() {			super();			alpha = 0;			// new Scaffold(this);		}		override public function transitionIn():void {			super.transitionIn();			TweenMax.to(this, 0.3, {alpha:1, onComplete:transitionInComplete});			_timer = new Timer(100, 1);						speaker.gotoAndPlay("apres");			this.addEventListener(Event.COMPLETE, _introFinie);		}		private function _introFinie(evt:Event):void {			_timer.start();			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _menuAccessible);		}		private function _menuAccessible(tEvt:TimerEvent):void {			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _menuAccessible);			_timer = null;			btn_didac.buttonMode = true;			btn_jouer.buttonMode = true;			btn_score.buttonMode = true;			btn_didac.addEventListener(MouseEvent.CLICK, _click);			btn_jouer.addEventListener(MouseEvent.CLICK, _click);			btn_score.addEventListener(MouseEvent.CLICK, _click);			btn_didac.addEventListener(MouseEvent.ROLL_OVER, _over);			btn_jouer.addEventListener(MouseEvent.ROLL_OVER, _over);			btn_score.addEventListener(MouseEvent.ROLL_OVER, _over);			btn_didac.addEventListener(MouseEvent.ROLL_OUT, _out);			btn_jouer.addEventListener(MouseEvent.ROLL_OUT, _out);			btn_score.addEventListener(MouseEvent.ROLL_OUT, _out);		}		private function _click(mEvt:MouseEvent):void {			btn_didac.removeEventListener(MouseEvent.CLICK, _click);			btn_jouer.removeEventListener(MouseEvent.CLICK, _click);			btn_score.removeEventListener(MouseEvent.CLICK, _click);			btn_didac.removeEventListener(MouseEvent.ROLL_OVER, _over);			btn_jouer.removeEventListener(MouseEvent.ROLL_OVER, _over);			btn_score.removeEventListener(MouseEvent.ROLL_OVER, _over);			btn_didac.removeEventListener(MouseEvent.ROLL_OUT, _out);			btn_jouer.removeEventListener(MouseEvent.ROLL_OUT, _out);			btn_score.removeEventListener(MouseEvent.ROLL_OUT, _out);			switch (mEvt.currentTarget) {				case btn_didac:					this.gotoAndPlay("out_home");					_timer = new Timer(4000, 1);					_timer.start();					_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _pouvoirLancerPartie);					break;				case btn_jouer:					this.gotoAndPlay("out_home");					_timer = new Timer(1000, 1);					_timer.start();					_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _jouer);					break;				case btn_score:					this.gotoAndPlay("out_home");					_timer = new Timer(1000, 1);					_timer.start();					_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _score);					break;			}		}		private function _score(tEvt:TimerEvent):void {			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _score);			_timer = null;			Gaia.api.goto(Pages.SCORE);		}		private function _jouer(tEvt:TimerEvent):void {			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _jouer);			_timer = null;			Gaia.api.goto(Pages.JEU);		}		private function _pouvoirLancerPartie(tEvt:TimerEvent):void {			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _pouvoirLancerPartie);			_timer = null;			btn_lancerJeu.buttonMode = true;			btn_lancerJeu.addEventListener(MouseEvent.CLICK, _lancerJeu);			btn_lancerJeu.addEventListener(MouseEvent.ROLL_OVER, _over);			btn_lancerJeu.addEventListener(MouseEvent.ROLL_OUT, _out);		}		private function _lancerJeu(event:MouseEvent):void {			btn_lancerJeu.removeEventListener(MouseEvent.CLICK, _lancerJeu);			btn_lancerJeu.removeEventListener(MouseEvent.ROLL_OVER, _over);			btn_lancerJeu.removeEventListener(MouseEvent.ROLL_OUT, _out);			Gaia.api.goto(Pages.JEU);		}		private function _over(mEvt:MouseEvent):void {			mEvt.currentTarget.gotoAndStop("over");		}		private function _out(mEvt:MouseEvent):void {			mEvt.currentTarget.gotoAndStop("base");		}		override public function transitionOut():void {			super.transitionOut();			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});		}	}}