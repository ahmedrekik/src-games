﻿package pages {	import com.gaiaframework.api.*;	import com.gaiaframework.templates.AbstractPage;	import com.greensock.TweenMax;		public class ScorePage extends AbstractPage	{			public function ScorePage()		{			super();			alpha = 0;			new Scaffold(this);		}		override public function transitionIn():void 		{			super.transitionIn();			TweenMax.to(this, 0.3, {alpha:1, onComplete:transitionInComplete});						if (Gaia.api.getPage(Pages.INDEX).content.scoreDefini == true) {				trace(Gaia.api.getPage(Pages.INDEX).content.score);			} else {				trace('le tricheur, il na pas joué');			}		}		override public function transitionOut():void 		{			super.transitionOut();			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});		}	}}