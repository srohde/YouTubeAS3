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
	import mx.core.IVisualElement;
	
	public interface IPlayer extends IVisualElement {
		
		[Bindable(event="proxyChange")]
		function get available() : Boolean;
		
		[Bindable(event="proxyChange")]
		function get duration() : Number;
		
		[Bindable(event="playingChange")]
		function get playing() : Boolean;
		
		/*function clearVideo() : void;
		   function cueVideoById( id : String ) : void;
		   function getAvailableQualityLevels() : Array;
		 function getCurrentTime() : Number;*/
		
		function setSize( width : uint, height : uint ) : void;
		
		function loadVideoById( id : String ) : void;
		
		function setPlaybackQuality( quality : String ) : void;
		
		function pauseVideo() : void;
		
		function playVideo() : void;
		
		function stopVideo() : void;
		
		function mute() : void;
		
		function unMute() : void;
		
		function setVolume( volume : Number ) : void;
		
		function seekTo( time : Number ) : void;
	}
}