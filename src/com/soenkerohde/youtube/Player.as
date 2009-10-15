/*
   Copyright 2009 Sönke Rohde

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
 */
package com.soenkerohde.youtube {
	
	import com.soenkerohde.youtube.event.PlayerEvent;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mx.core.UIComponent;
	
	public class Player extends UIComponent implements IPlayer {
		
		private var loader:Loader;
		private var proxy:Object;
		
		private var _playing:Boolean = true;
		
		[Bindable(event="proxyChange")]
		public function get duration() : Number {
			return proxy.getDuration();
		}
		
		[Bindable(event="proxyChange")]
		public function get available() : Boolean {
			return proxy != null;
		}
		
		[Bindable(event="playingChange")]
		public function get playing() : Boolean {
			return _playing;
		}
		
		public function Player() {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.INIT, onLoaderInit );
			loader.load( new URLRequest( "http://www.youtube.com/apiplayer?version=3" ) );
		}
		
		protected function onLoaderInit( event : Event ) : void {
			trace( "onLoaderInit" );
			setProxy( loader.content );
			loader.content.addEventListener( "onReady", onPlayerReady );
			loader.content.addEventListener( "onError", onPlayerError );
			loader.content.addEventListener( "onStateChange", onPlayerStateChange );
			loader.content.addEventListener( "onPlaybackQualityChange",
											 onVideoPlaybackQualityChange );
			addChild( loader.content );
		}
		
		protected function onPlayerReady( event : Event ) : void {
			// Event.data contains the event parameter, which is the Player API ID 
			trace( "player ready:", Object( event ).data );
			
			// Once this event has been dispatched by the player, we can use
			// cueVideoById, loadVideoById, cueVideoByUrl and loadVideoByUrl
			// to load a particular YouTube video.
			
			dispatchEvent( new PlayerEvent( PlayerEvent.READY ) );
		}
		
		public function setProxy( proxy : Object ) : void {
			this.proxy = proxy;
			dispatchEvent( new Event( "proxyChange" ) );
		}
		
		public function setSize( width : uint, height : uint ) : void {
			proxy.setSize( width, height );
		}
		
		public function loadVideoById( id : String ) : void {
			proxy.loadVideoById( id );
		}
		
		public function pauseVideo() : void {
			_playing = false;
			dispatchEvent( new Event( "playingChange" ) );
			proxy.pauseVideo();
		}
		
		public function playVideo() : void {
			_playing = true;
			dispatchEvent( new Event( "playingChange" ) );
			proxy.playVideo();
		}
		
		public function seekTo( time : Number ) : void {
			proxy.seekTo( time );
		}
		
		protected function onPlayerError( event : Event ) : void {
			// Event.data contains the event parameter, which is the error code
			trace( "player error:", Object( event ).data );
		}
		
		protected function onPlayerStateChange( event : Event ) : void {
			// Event.data contains the event parameter, which is the new player state
			trace( "player state:", Object( event ).data );
			
			dispatchEvent( new Event( "proxyChange" ) );
		}
		
		protected function onVideoPlaybackQualityChange( event : Event ) : void {
			// Event.data contains the event parameter, which is the new video quality
			trace( "video quality:", Object( event ).data );
		}
	
	}
}