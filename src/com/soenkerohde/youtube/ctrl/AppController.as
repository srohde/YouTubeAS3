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
package com.soenkerohde.youtube.ctrl {
	import com.soenkerohde.youtube.IPlayer;
	import com.soenkerohde.youtube.event.PlayerEvent;
	import com.soenkerohde.youtube.view.AppView;
	
	import org.swizframework.factory.IInitializingBean;
	
	public class AppController implements IInitializingBean {
		
		[Autowire]
		public var player:IPlayer;
		
		[Autowire(view="true")]
		public var appView:AppView;
		
		public function AppController() {
		}
		
		public function initialize() : void {
			player.addEventListener( PlayerEvent.READY, playerReadyHandler );
		}
		
		private function playerReadyHandler( e : PlayerEvent ) : void {
			appView.addElementAt( player, 0 );
			//player.loadVideoById( "y1ZyKTVGjX0" );
			player.setSize( appView.stage.width, appView.stage.height - 24 );
		}
	
	}
}