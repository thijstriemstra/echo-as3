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
	import com.collab.echo.view.hub.chat.Chat;
	import com.collab.echo.view.hub.display.skins.BaseCommunicationPanelSkin;
	import com.collab.echo.view.hub.translator.Translator;
	import com.collab.echo.view.hub.video.VideoScrollPane;
	import com.collab.echo.view.hub.whiteboard.display.Whiteboard;
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import fl.events.ScrollEvent;
	
	import org.osflash.thunderbolt.Logger;

	/**
	 * Communication hub.
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
		
		internal var _pane				: FlashScrollPane;
		internal var _whiteboard		: Whiteboard;
		internal var _chat				: Chat;
		internal var _translator		: Translator;
		internal var _videoPane			: VideoScrollPane;
		internal var _expandButton		: BaseExpandButton;
		
		internal var _skin				: Object;
		internal var _paddingLeft		: int;
		internal var _data				: Vector.<UserVO>;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		public function set skin( val:Object ):void
		{
			_skin = val;
			invalidate();
		}
		
		public function set paddingLeft( val:int ):void
		{
			_paddingLeft = val;
			invalidate();
		}
		
		/**
		 * Users.
		 * 
		 * @param val
		 */		
		public function set data( val:Vector.<UserVO> ):void
		{
			_data = val;
			
			if ( _videoPane )
			{
				// update/reset components
				_videoPane.data = _data;
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
			
			_paddingLeft = paddingLeft;
			
			show();
		}
		
		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================
		
		public function addOccupant( client:* ):void
		{
			trace( 'BaseCommunicationPanel.addOccupant: ' + client );
			
			// XXX: _videoPane (and others) need a addOccupant method
		}
		
		public function removeOccupant( client:* ):void
		{
			trace( 'BaseCommunicationPanel.removeOccupant: ' + client );
			
			// XXX: _videoPane (and others) need a removeOccupant method
		}
		
		/**
		 * Instantiate and add child(ren) to display list.
		 */	
		override protected function draw() : void
		{
			// pane
			_pane = _skin.pane;
			_pane.setSize( PANEL_WIDTH_MIN, viewHeight );
			_pane.addEventListener( ScrollEvent.SCROLL, scrollHandler, false, 0, true );
			addChild( _pane );
			
			// video pane
			_videoPane = _skin.videoPane;
			_videoPane.panelSkin = _skin.userPanel;
			_videoPane.data = _data;
			_videoPane.setSize( viewWidth, 200 );
			_pane.add( _videoPane );
			
			// whiteboard
			_whiteboard = _skin.whiteboard;
			_whiteboard.hide();
			_pane.add( _whiteboard );
			
			// chat
			_chat = _skin.chat;
			_chat.setSize( 350, 520 );
			_pane.add( _chat );
			
			// translator
			_translator = _skin.translator;
			_translator.setSize( 250, 520 );
			_pane.add( _translator );
			
			// expand button
			_expandButton = _skin.expandButton;
			_expandButton.width = _pane.width;
			_expandButton.addEventListener( CommunicationPanelEvent.EXPAND, onExpandPanel,
										 false, 0, true );
			_expandButton.addEventListener( CommunicationPanelEvent.COLLAPSE, onExpandPanel,
										 false, 0, true );
			addChild( _expandButton );
		}
		
		/**
		 * Position child(ren) on display list.
		 */
		override protected function layout():void
		{
			// expand button
			_expandButton.y = _pane.height;
			
			// video pane
			_videoPane.x = 0;
			_videoPane.y = 0;
			
			// whiteboard
			_whiteboard.x = 0;
			_whiteboard.y = _videoPane.y + _videoPane.height;
			
			// chat
			_chat.x = 0;
			_chat.y = _videoPane.y + _videoPane.height;
			
			// translator
			_translator.x = _chat.width;
			_translator.y = _videoPane.y + _videoPane.height;
		}
		
		/**
		 * Remove and redraw child(ren).
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _whiteboard );
			removeChildFromDisplayList( _chat );
			removeChildFromDisplayList( _translator );
			removeChildFromDisplayList( _videoPane );
			removeChildFromDisplayList( _pane );
			removeChildFromDisplayList( _expandButton );
			
			super.invalidate();
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 */		
		protected function onExpandPanel( event:CommunicationPanelEvent ):void
		{
			Logger.debug( event.toString() );
			
			switch ( event.type )
			{
				case CommunicationPanelEvent.EXPAND:
					TweenLite.to( _pane, 1, { x: -(viewWidth - (PANEL_WIDTH_MIN + _paddingLeft)), ease: Quad.easeOut,
											 setSize:{ width: viewWidth - PANEL_WIDTH_MIN }}); 
					break;
				
				case CommunicationPanelEvent.COLLAPSE:
					TweenLite.to( _pane, 1, { x: 0, setSize:{ width: PANEL_WIDTH_MIN }, ease: Quad.easeIn }); 
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