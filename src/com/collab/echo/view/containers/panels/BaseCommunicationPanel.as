/*
Echo project.

Copyright (C) 2003-2010 Collab

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
package com.collab.echo.view.containers.panels
{
	import com.collab.echo.events.CommunicationPanelEvent;
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.view.containers.scrollpane.FlashScrollPane;
	import com.collab.echo.view.controls.buttons.BaseExpandButton;
	import com.collab.echo.view.hub.chat.display.Chat;
	import com.collab.echo.view.hub.chat.messages.BaseChatMessage;
	import com.collab.echo.view.hub.display.skins.BaseCommunicationPanelSkin;
	import com.collab.echo.view.hub.translator.display.Translator;
	import com.collab.echo.view.hub.video.containers.scrollpane.VideoScrollPane;
	import com.collab.echo.view.hub.whiteboard.display.Whiteboard;
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import fl.events.ScrollEvent;
	
	import org.osflash.thunderbolt.Logger;

	/**
	 * Communication hub view.
	 * 
	 * <p>Internal <code>FlashScrollPane</code> contains:</p>
	 * <p><ul>
	 * <li><code>Whiteboard</code></li>
	 * <li><code>Chat</code></li>
	 * <li><code>Translator</code></li>
	 * <li><code>VideoScrollPane</code></li>
	 * <li><code>BaseExpandButton</code></li>
	 * </ul></p>
	 * 
	 * @see com.collab.echo.view.containers.scrollpane.FlashScrollPane FlashScrollPane
	 * @see com.collab.echo.view.hub.chat.display.Chat Chat
	 * @see com.collab.echo.view.hub.translator.display.Translator Translator
	 * @see com.collab.echo.view.hub.whiteboard.display.Whiteboard Whiteboard
	 * @see com.collab.echo.view.hub.video.containers.scrollpane.VideoScrollPane VideoScrollPane
	 * @see com.collab.echo.view.controls.buttons.BaseExpandButton BaseExpandButton
	 * 
	 * @author Thijs Triemstra
	 */	
	public class BaseCommunicationPanel extends Panel
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		/**
		 * The initial width of the panel. 
		 */		
		public static const PANEL_WIDTH_MIN		: int = 140;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _skin						: Object;
		private var _paddingLeft				: int;
		private var _welcomeMessage				: String;
		private var _sendLabel					: String;
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * The active users. 
		 */		
		protected var data						: Vector.<UserVO>;
		
		/**
		 * The scroll pane where the panel's components are attached to. 
		 */		
		protected var pane						: FlashScrollPane;
		
		/**
		 * The whiteboard component. 
		 */		
		protected var whiteboard				: Whiteboard;
		
		/**
		 * The chat component. 
		 */		
		protected var chat						: Chat;
		
		/**
		 * The translator component. 
		 */		
		protected var translator				: Translator;
		
		/**
		 * The video pane component containing the video panels. 
		 */		
		protected var videoPane					: VideoScrollPane;
		
		/**
		 * The button that expands the panel. 
		 */		
		protected var expandButton				: BaseExpandButton;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * Panel skin.
		 *  
		 * @param val
		 */		
		public function set skin( val:Object ):void
		{
			if ( val )
			{
				_skin = val;
				invalidate();
			}
		}
		public function get skin():Object
		{
			return _skin;
		}

		/**
		 * Padding on the left side.
		 *  
		 * @param val
		 */		
		public function set paddingLeft( val:int ):void
		{
			if ( val )
			{
				_paddingLeft = val;
				invalidate();
			}
		}
		public function get paddingLeft():int
		{
			return _paddingLeft;
		}
		
		/**
		 * Welcome message for the <code>Chat</code>.
		 * 
		 * @param val
		 */		
		public function set welcomeMessage( val:String ):void
		{
			if ( val )
			{
				_welcomeMessage = val;
				invalidate();
			}
		}
		public function get welcomeMessage():String
		{
			return _welcomeMessage;
		}
		
		/**
		 * Label for the <code>Chat</code>'s send button.
		 * @param val
		 */		
		public function set sendLabel( val:String ):void
		{
			if ( val )
			{
				_sendLabel = val;
				invalidate();
			}
		}
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 * @param skin
		 * @param paddingLeft
		 */		
		public function BaseCommunicationPanel( width:int, height:int, skin:Object=null,
												paddingLeft:int=0 )
		{
			super( true, width, height );
			
			if ( skin == null )
			{
				_skin = BaseCommunicationPanelSkin.getSkin();
			}
			else
			{
				_skin = skin;
			}
			
			data = new Vector.<UserVO>();
			_paddingLeft = paddingLeft;
			
			show();
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Notify the panel's components that a client joined the room.
		 * 
		 * @param client
		 */		
		public function joinedRoom( client:UserVO ):void
		{
			//Logger.debug( 'BaseCommunicationPanel.joinedRoom: ' + client );
			
			chat.joinedRoom( client );
			videoPane.joinedRoom( client );
			whiteboard.joinedRoom( client );
		}
		
		/**
		 * Add a new occupant to the panel's components.
		 *  
		 * @param client
		 */		
		public function addOccupant( client:UserVO ):UserVO
		{
			// add the user to the data provider
			data.push( client );
			
			//Logger.debug( 'BaseCommunicationPanel.addOccupant: ' + client );
			
			// add occupant to components
			videoPane.addUser( client );
			chat.addUser( client );
			whiteboard.addUser( client );
			
			return client;
		}
		
		/**
		 * Remove an existing occupant from the panel's components.
		 *  
		 * @param client
		 */		
		public function removeOccupant( client:UserVO ):UserVO
		{
			var myGuy:UserVO;
			var index:int = 0;
			
			// find the user
			for each ( myGuy in data )
			{
				if ( myGuy == client )
				{
					// remove the user from the data provider
					data.splice( index, 1 );
					break;
				}
				index++;
			}
			
			//Logger.debug( 'BaseCommunicationPanel.removeOccupant: ' + client );
			
			// remove occupant from components
			videoPane.removeUser( client );
			whiteboard.removeUser( client );
			chat.removeUser( client );
			
			return client;
		}
		
		/**
		 * Notify the panel's component that the clients in the room updated.
		 * 
		 * @param totalClients
		 */		
		public function numClients( totalClients:int ):void
		{
			chat.numClients( totalClients );
			videoPane.numClients( totalClients );
			whiteboard.numClients( totalClients );
		}
		
		/**
		 * Add a new message to the <code>Chat</code>.
		 * 
		 * @param message
		 */		
		public function addMessage( message:BaseChatMessage ):void
		{
			chat.addMessage( message );
		}

		/**
		 * Add a new line to the <code>Whiteboard</code>.
		 * 
		 * @param message
		 */		
		public function addLine( message:Object ):void
		{
			whiteboard.addLine( message );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Instantiate and add child(ren) to display list.
		 * 
		 * @private
		 */	
		override protected function draw() : void
		{
			// pane
			pane = _skin.pane;
			pane.setSize( PANEL_WIDTH_MIN, viewHeight );
			pane.addEventListener( ScrollEvent.SCROLL, scrollHandler, false, 0, true );
			addChild( pane );
			
			// video pane
			videoPane = _skin.videoPane;
			videoPane.panelSkin = _skin.userPanel;
			videoPane.setSize( viewWidth, 200 );
			pane.add( videoPane );
			
			// chat
			chat = _skin.chat;
			chat.welcomeMessage = _welcomeMessage;
			chat.sendLabel = _sendLabel;
			chat.setSize( 350, 383 );
			pane.add( chat );
			
			// whiteboard
			whiteboard = _skin.whiteboard;
			whiteboard.setSize( 300, 265 );
			pane.add( whiteboard );
			
			// translator
			translator = _skin.translator;
			translator.setSize( 250, 520 );
			pane.add( translator );
			
			// expand button
			expandButton = _skin.expandButton;
			expandButton.width = pane.width;
			expandButton.addEventListener( CommunicationPanelEvent.EXPAND, onExpandPanel,
										    false, 0, true );
			expandButton.addEventListener( CommunicationPanelEvent.COLLAPSE, onExpandPanel,
										    false, 0, true );
			addChild( expandButton );
		}
		
		/**
		 * Position child(ren) on display list.
		 * 
		 * @private
		 */
		override protected function layout():void
		{
			// expand button
			expandButton.y = pane.height;
			
			// video pane
			videoPane.x = 0;
			videoPane.y = 0;
			
			var compY:int = videoPane.y + videoPane.height;
			
			// chat
			chat.x = 0;
			chat.y = compY;
			
			// whiteboard
			whiteboard.x = chat.x + chat.width;
			whiteboard.y = compY;
			
			// translator
			translator.x = whiteboard.x + whiteboard.width;
			translator.y = compY;
		}
		
		/**
		 * Remove and redraw child(ren).
		 * 
		 * @private
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( whiteboard );
			removeChildFromDisplayList( chat );
			removeChildFromDisplayList( translator );
			removeChildFromDisplayList( videoPane );
			removeChildFromDisplayList( pane );
			removeChildFromDisplayList( expandButton );
			
			super.invalidate();
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * Invoked when the panel is expanded and collapsed.
		 * 
		 * <p>Expand and collapses the panel.</p>
		 * 
		 * @param event
		 */		
		protected function onExpandPanel( event:CommunicationPanelEvent ):void
		{
			Logger.debug( event.toString() );
			
			switch ( event.type )
			{
				case CommunicationPanelEvent.EXPAND:
					TweenLite.to( pane, 1, { x: -(viewWidth - (PANEL_WIDTH_MIN + _paddingLeft)), ease: Quad.easeOut,
											 setSize:{ width: viewWidth - PANEL_WIDTH_MIN }}); 
					break;
				
				case CommunicationPanelEvent.COLLAPSE:
					TweenLite.to( pane, 1, { x: 0, setSize:{ width: PANEL_WIDTH_MIN }, ease: Quad.easeIn }); 
					break;
			}
		}
		
		/**
		 * Invoked when the panel is scrolled.
		 * 
		 * @param event
		 */		
		protected function scrollHandler( event:ScrollEvent ):void
		{
		}
		
	}
}