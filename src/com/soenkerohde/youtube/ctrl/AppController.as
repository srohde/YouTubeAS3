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