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
package com.collab.echo.view.hub.display
{
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.view.containers.panels.Panel;
	import com.collab.echo.view.containers.scrollpane.FlashScrollPane;
	import com.collab.echo.view.controls.buttons.BaseExpandButton;
	import com.collab.echo.view.events.CommunicationPanelEvent;
	import com.collab.echo.view.hub.chat.display.Chat;
	import com.collab.echo.view.hub.chat.messages.BaseChatMessage;
	import com.collab.echo.view.hub.display.skins.BaseCommunicationPanelSkin;
	import com.collab.echo.view.hub.translator.Translator;
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
	 * @see com.collab.echo.view.hub.chat.Chat Chat
	 * @see com.collab.echo.view.hub.translator.Translator Translator
	 * @see com.collab.echo.view.hub.whiteboard.Whiteboard Whiteboard
	 * @see com.collab.echo.view.hub.VideoScrollPane VideoScrollPane
	 * @see com.collab.echo.view.controls.buttons.BaseExpandButton BaseExpandButton
	 * 
	 * @author Thijs Triemstra
	 */	
	public class BaseCommunicationPanel extends Panel
	{
		// ====================================
		// STATIC VARS
		// ====================================
		
		internal static const PANEL_WIDTH_MIN	: int = 140;
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var _skin						: Object;
		internal var _paddingLeft				: int;
		internal var _welcomeMessage			: String;
		internal var _sendLabel					: String;
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var data						: Vector.<UserVO>;
		protected var pane						: FlashScrollPane;
		protected var whiteboard				: Whiteboard;
		protected var chat						: Chat;
		protected var translator				: Translator;
		protected var videoPane					: VideoScrollPane;
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
			_skin = val;
			invalidate();
		}

		/**
		 * Padding on the left side.
		 *  
		 * @param val
		 */		
		public function set paddingLeft( val:int ):void
		{
			_paddingLeft = val;
			invalidate();
		}
		
		/**
		 * @param val
		 */		
		public function set welcomeMessage( val:String ):void
		{
			_welcomeMessage = val;
			invalidate();
		}
		
		/**
		 * @param val
		 */		
		public function set sendLabel( val:String ):void
		{
			_sendLabel = val;
			invalidate();
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
		 * Add a new occupant to the <code>Room</code>.
		 *  
		 * @param client
		 */		
		public function addOccupant( client:* ):UserVO
		{
			// override in subclass
			return null;
		}
		
		/**
		 * Remove an existing occupant from the room.
		 *  
		 * @param client
		 */		
		public function removeOccupant( client:* ):UserVO
		{
			// override in subclass
			return null;
		}
		
		/**
		 * Total clients in room updated.
		 * 
		 * @param totalClients
		 */		
		public function numClients( totalClients:int ):void
		{
			// override in subclass
		}
		
		/**
		 * Joined the room.
		 * 
		 * @param data
		 */		
		public function joinedRoom( data:* ):void
		{
			// override in subclass
		}
		
		/**
		 * @param message
		 */		
		public function addMessage( message:BaseChatMessage ):void
		{
			chat.addMessage( message );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Instantiate and add child(ren) to display list.
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
			
			// whiteboard
			whiteboard = _skin.whiteboard;
			whiteboard.setSize( 200, 520 );
			whiteboard.hide();
			pane.add( whiteboard );
			
			// chat
			chat = _skin.chat;
			chat.welcomeMessage = _welcomeMessage;
			chat.sendLabel = _sendLabel;
			chat.setSize( 350, 385 );
			pane.add( chat );
			
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
		 */
		override protected function layout():void
		{
			// expand button
			expandButton.y = pane.height;
			
			// video pane
			videoPane.x = 0;
			videoPane.y = 0;
			
			// whiteboard
			whiteboard.x = 0;
			whiteboard.y = videoPane.y + videoPane.height;
			
			// chat
			chat.x = 0;
			chat.y = videoPane.y + videoPane.height;
			
			// translator
			translator.x = chat.width;
			translator.y = videoPane.y + videoPane.height;
		}
		
		/**
		 * Remove and redraw child(ren).
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
		 * @param event
		 */		
		protected function scrollHandler( event:ScrollEvent ):void
		{
		}
		
	}
}