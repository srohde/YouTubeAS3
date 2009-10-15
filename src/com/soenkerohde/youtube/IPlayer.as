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
	import mx.core.IVisualElement;
	
	public interface IPlayer extends IVisualElement {
		
		[Bindable(event="proxyChange")]
		function get available() : Boolean;
		
		[Bindable(event="proxyChange")]
		function get duration() : Number;
		
		[Bindable(event="playingChange")]
		function get playing() : Boolean;
		
		function setSize( width : uint, height : uint ) : void;
		
		function loadVideoById( id : String ) : void;
		
		function pauseVideo() : void;
		
		function playVideo() : void;
		
		function seekTo( time : Number ) : void;
	}
}