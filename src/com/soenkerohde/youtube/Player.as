/*
   Copyright (c) 2009 Sönke Rohde

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
   THE SOFTWARE.
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
		
		public function setPlaybackQuality( quality : String ) : void {
			// TODO implement setPlaybackQuality
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
		
		public function stopVideo() : void {
			_playing = false;
			dispatchEvent( new Event( "playingChange" ) );
			proxy.stopVideo();
		}
		
		public function mute() : void {
			proxy.mute();
		}
		
		public function unMute() : void {
			proxy.unMute();
		}
		
		public function setVolume( volume : Number ) : void {
			proxy.setVolume( volume );
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