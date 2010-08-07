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
package com.collab.echo.view.hub.chat.display
{
	import com.collab.echo.containers.panels.MenuPanel;
	import com.collab.echo.controls.ChatInput;
	import com.collab.echo.events.ChatEvent;
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.util.DateUtils;
	import com.collab.echo.view.hub.chat.messages.BaseChatMessage;
	import com.collab.echo.view.hub.interfaces.IChatRoom;
	
	import fl.controls.TextArea;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * Chat.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class Chat extends MenuPanel implements IChatRoom
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		/**
		 * 
		 */		
		public static const HISTORY_MAX_LENGTH		: int = 20;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _welcomeMessage					: String;
		private var _sendLabel						: String;
		private var _playSound						: Boolean;
		private var _showTimestamp					: Boolean;
		private var _soundFactory					: Sound;
		private var _messageSound					: SoundChannel;
		
		//_messageSound.attachSound("messageGeluid");
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		// XXX: find replacement for fl.controls
		/**
		 * 
		 */		
		protected var textArea						: TextArea;
		
		/**
		 * 
		 */		
		protected var messageHistory				: Array;
		
		/**
		 * 
		 */		
		protected var inputField					: ChatInput;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get playSound():Boolean
		{
			return _playSound;
		}
		public function set playSound( val:Boolean ):void
		{
			_playSound = val;
		}

		/**
		 * @return 
		 */		
		public function get showTimestamp():Boolean
		{
			return _showTimestamp;
		}
		public function set showTimestamp( val:Boolean ):void
		{
			_showTimestamp = val;
		}
		
		/**
		 * @return 
		 */		
		public function get welcomeMessage()		: String
		{
			return _welcomeMessage;
		}
		public function set welcomeMessage( val:String ):void
		{
			if ( val )
			{
				_welcomeMessage = val;
				invalidate();
			}
		}
		
		/**
		 * @return 
		 */		
		public function get sendLabel()				: String
		{
			return _sendLabel;
		}
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
		 */		
		public function Chat( width:Number=0, height:Number=0 )
		{
			_playSound = false;
			_showTimestamp = true;
			
			this.messageHistory = [];
			// XXX: move elsewhere
			this.menuItems = [ "aaa", "bbb", "ccc" ];
			
			super( width, height );
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
		public function addUser( client:UserVO ):void
		{
			//Logger.debug( "Chat.addUser: " + client );
		}
		
		/**
		 * Remove an existing occupant from the room.
		 * 
		 * @param client
		 */		
		public function removeUser( client:UserVO ):void
		{
			//Logger.debug( "Chat.removeUser: " + client );
			
			textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}
		
		/**
		 * Joined the room.
		 * 
		 * @param client
		 */		
		public function joinedRoom( client:UserVO ):void
		{
			//Logger.debug( "Chat.joinedRoom: " + client );
		}
		
		/**
		 * Total clients in room updated.
		 * 
		 * @param totalClients
		 */		
		public function numClients( totalClients:int ):void
		{
			//Logger.debug( "Chat.numClients: " + totalClients );
		}
		
		/**
		 * Add a chat message to the <code>textArea</code>.
		 * 
		 * @param data
		 */		
		public function addMessage( data:BaseChatMessage ):void
		{
			var addStamp:String = "";
			var text:String = "";
			
			// update history
			updateHistory( data.message );
			
			// play sound
			if ( _playSound )
			{
				//_messageSound.play();
			}
			
			// cutoff lines
			if ( data.append )
			{
				truncateChatField( textArea );
			}
			
			// add timestamp
			if ( _showTimestamp )
			{
				addStamp = DateUtils.createClientStamp();
			}
			
			// add text to chat
			text = addStamp + " " + data.message;
			
			if ( data.append )
			{
				// append
				textArea.htmlText += text;
			}
			else
			{
				// replace
				textArea.htmlText = text;
			}

			// scroll chat to bottom
			textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}

		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Update the history.
		 * 
		 * @param msg
		 */		
		protected function updateHistory( msg:String ):void
		{
			// add message to history list if its not the same as previous
			if ( msg != messageHistory[ messageHistory.length - 1 ])
			{
				// limit the history
				if ( messageHistory.length > HISTORY_MAX_LENGTH )
				{
					messageHistory.shift();
				}
				
				// add message to history
				messageHistory.push( msg );
			}
		}
		
		/**
		 * Instantiate and add child(ren) to display list.
		 * 
		 * @private
		 */	
		override protected function draw():void
		{
			super.draw();
			
			// input
			inputField = new ChatInput( viewWidth );
			inputField.addEventListener( ChatEvent.HISTORY_DOWN, onHistoryDown,
										 false, 0, true );
			inputField.addEventListener( ChatEvent.HISTORY_UP, onHistoryUp,
										 false, 0, true );
			inputField.text = _welcomeMessage;
			inputField.buttonLabel = _sendLabel;
			addChild( inputField );
			
			// textArea
			var h:int = viewHeight - ( inputField.height + bar.height );
			textArea = new TextArea();
			textArea.setSize( viewWidth, h ); 
			textArea.condenseWhite = true; 
			textArea.editable = false;
			addChild( textArea );
		}
		
		/**
		 * Position child(ren) on display list.
		 * 
		 * @private
		 */
		override protected function layout():void
		{
			super.layout();
			
			// textArea
			textArea.x = 0;
			textArea.y = bar.y + bar.height;
			
			// inputField
			inputField.x = 0;
			inputField.y = textArea.y + textArea.height;
		}
		
		/**
		 * Remove and redraw child(ren).
		 * 
		 * @private
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( inputField );
			removeChildFromDisplayList( textArea );
			
			super.invalidate();
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 * @private
		 */		
		protected function onHistoryUp( event:ChatEvent ):void
		{
			event.stopImmediatePropagation();
			
			trace( 'onHistoryUp: ' + event );
		}
		
		/**
		 * @param event
		 * @private
		 */		
		protected function onHistoryDown( event:ChatEvent ):void
		{
			event.stopImmediatePropagation();
			
			trace( 'onHistoryDown: ' + event );
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		// XXX: refactor
		
		/**
		 * Trim the chat text field.
		 *  
		 * @param welke
		 * @return 
		 * @private
		 */		
		internal function truncateChatField( welke:TextArea ):void
		{
			if (welke.text.length > 15000)
			{
				var startTrim:Number = welke.text.indexOf('<P ALIGN="LEFT">', 1000);
				welke.text = welke.text.substring(startTrim);
			}
		}
		
		/**
		 * Trim text.
		 * 
		 * @param welke
		 * @private
		 */		
		internal function truncateTxt(welke:TextArea):void
		{
			var maxChars:Number = 15000;
			if (welke.text.length > maxChars) 
			{
				var startTrim:Number = welke.text.indexOf('<P ALIGN="LEFT">', 1000);
				welke.text = welke.text.substring(startTrim);
			}
		}
		
	}
}