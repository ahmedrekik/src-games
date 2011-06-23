﻿package pages {	import flash.media.SoundMixer;	import com.gaiaframework.api.IBitmap;	import com.gaiaframework.api.IBitmapSprite;	import com.gaiaframework.templates.AbstractPage;	import com.greensock.TweenMax;	import flash.display.Bitmap;	import flash.display.Loader;	import flash.display.MovieClip;	import flash.display.Shape;	import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.net.URLRequest;	public class HomePage extends AbstractPage {		private var _background:Bitmap;		private var _play:Sprite;		private var _tablette:Sprite;		private var _mobile:Sprite;		private var _passer:Sprite;		private var _gameContainer:Sprite;		private var _videoIntro:MovieClip;		private var _shapeMask:Shape;		public function HomePage() {			super();			alpha = 0;		}		override public function transitionIn():void {			super.transitionIn();			TweenMax.to(this, 0.3, {alpha:1, onComplete:transitionInComplete});			_background = new Bitmap(IBitmap(assets.imgHome).bitmapData);			_background.x = (stage.stageWidth - _background.width) / 2;			addChild(_background);			_play = new Sprite();			addChild(_play);			_play.addChild(IBitmapSprite(assets.btnPlay).container);			_play.buttonMode = true;			_play.name = "play";			IBitmapSprite(assets.btnPlay).visible = true;			_play.x = (stage.stageWidth - _play.width) / 2 - 150;			_play.y = 425;			_tablette = new Sprite();			addChild(_tablette);			_tablette.addChild(IBitmapSprite(assets.btnAppli).container);			_tablette.buttonMode = true;			_tablette.name = "tablette";			IBitmapSprite(assets.btnAppli).visible = true;			_tablette.x = (stage.stageWidth - _tablette.width) / 2 - 100;			_tablette.y = 650;			_mobile = new Sprite();			addChild(_mobile);			_mobile.addChild(IBitmapSprite(assets.btnMobile).container);			_mobile.buttonMode = true;			_mobile.name = "mobile";			IBitmapSprite(assets.btnMobile).visible = true;			_mobile.x = (stage.stageWidth - _mobile.width) / 2 + 200;			_mobile.y = 650;			_play.addEventListener(MouseEvent.CLICK, _click);			_tablette.addEventListener(MouseEvent.CLICK, _click);			_mobile.addEventListener(MouseEvent.CLICK, _click);			stage.addEventListener(Event.RESIZE, _onResize);		}		private function _click(mEvt:MouseEvent):void {			switch (mEvt.currentTarget.name) {				case "play":					_gameContainer = new Sprite();					addChild(_gameContainer);					_gameContainer.addChild(IBitmapSprite(assets.gameContainer).container);					IBitmapSprite(assets.gameContainer).visible = true;					_gameContainer.x = (stage.stageWidth - _gameContainer.width) / 2;					_gameContainer.y = 245;					var loader:Loader = new Loader();					loader.load(new URLRequest("video/intro.swf"));					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _gameLoaded);					break;				case "tablette":					trace("tablette à dl");					break;				case "mobile":					trace("mobile à dl");					break;				case "passer":					_videoComplete();					break;			}		}		private function _gameLoaded(evt:Event):void {						_videoIntro = evt.target.content;						evt.target.removeEventListener(Event.COMPLETE, _gameLoaded);			_shapeMask = new Shape();			_shapeMask.graphics.beginFill(0xFF00000);			_shapeMask.graphics.drawRoundRect(45, 50, 950, 650, 10, 10);			_shapeMask.graphics.endFill();			_gameContainer.addChild(_shapeMask);			stage.frameRate = 24;			_gameContainer.addChild(_videoIntro);			_videoIntro.x = 50;			_videoIntro.y = 50;			evt.target.content.mask = _shapeMask;			_passer = new Sprite();			addChild(_passer);			_passer.addChild(IBitmapSprite(assets.btnPasser).container);			_passer.buttonMode = true;			_passer.name = "passer";			IBitmapSprite(assets.btnPasser).visible = true;			_passer.x = (stage.stageWidth - _tablette.width) / 2 + 490;			_passer.y = 875;			_passer.addEventListener(MouseEvent.CLICK, _click);			_videoIntro.addEventListener("video_complete", _videoComplete);		}		private function _videoComplete(evt:Event = null):void {			_passer.removeEventListener(MouseEvent.CLICK, _click);			removeChild(_passer);			_passer = null;						SoundMixer.stopAll();			_videoIntro.removeEventListener("video_complete", _videoComplete);			_gameContainer.removeChild(_videoIntro);						_videoIntro = null;			stage.frameRate = 31;			var loader:Loader = new Loader();			loader.load(new URLRequest("KinessiaGame.swf"));			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _playGame);		}		private function _playGame(evt:Event):void {			evt.target.removeEventListener(Event.COMPLETE, _gameLoaded);			_gameContainer.addChild(evt.target.content);			evt.target.content.x = 50;			evt.target.content.y = 50;			evt.target.content.mask = _shapeMask;			evt.target.content.addEventListener("video_complete", _videoComplete);		}		private function _onResize(evt:Event):void {			_background.x = (stage.stageWidth - _background.width) / 2;			_play.x = (stage.stageWidth - _play.width) / 2 - 150;			_tablette.x = (stage.stageWidth - _tablette.width) / 2 - 100;			_mobile.x = (stage.stageWidth - _mobile.width) / 2 + 200;		}		override public function transitionOut():void {			stage.removeEventListener(Event.RESIZE, _onResize);			_play.removeEventListener(MouseEvent.CLICK, _click);			_tablette.removeEventListener(MouseEvent.CLICK, _click);			_mobile.removeEventListener(MouseEvent.CLICK, _click);			super.transitionOut();			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});		}	}}