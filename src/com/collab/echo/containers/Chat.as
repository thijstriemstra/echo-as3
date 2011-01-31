/*
Echo project.

Copyright (C) 2003-2011 Collab

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
package com.collab.echo.containers
{
	import com.collab.cabin.display.util.TextUtils;
	import com.collab.cabin.log.Logger;
	import com.collab.cabin.util.DateUtils;
	import com.collab.cabin.util.StringUtil;
	import com.collab.echo.containers.panels.MenuPanel;
	import com.collab.echo.controls.ChatInput;
	import com.collab.echo.core.messages.chat.ChatMessage;
	import com.collab.echo.core.rooms.IChatRoom;
	import com.collab.echo.core.rooms.IRoom;
	import com.collab.echo.events.ChatEvent;
	import com.collab.echo.model.UserVO;
	
	import fl.controls.TextArea;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.Font;
	
	/**
	 * Chat panel.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class Chat extends MenuPanel implements IRoom, IChatRoom
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		/**
		 * Max length of chat history.
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
		 * Add a new occupant to the room.
		 * 
		 * @param client
		 */		
		public function addOccupant( client:UserVO ):void
		{
			Logger.debug( "Chat.addOccupant: " + client );
		}
		
		/**
		 * Remove an existing occupant from the room.
		 * 
		 * @param client
		 */		
		public function removeOccupant( client:UserVO ):void
		{
			Logger.debug( "Chat.removeOccupant: " + client );
			
			textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}
		
		/**
		 * @param client
		 * @param attr
		 */		
		public function clientAttributeUpdate( client:UserVO,
											   attr:Object ):void
		{
			
		}
		
		/**
		 * Local client joined the room.
		 * 
		 * @param client
		 */		
		public function joinedRoom( client:UserVO ):void
		{
			Logger.debug( "Chat.joinedRoom: " + client );
		}
		
		/**
		 * Total clients in room was updated.
		 * 
		 * @param total
		 */		
		public function numClients( total:int ):void
		{
			Logger.debug( "Chat.numClients: " + total );
		}
		
		/**
		 * Add a chat message to the <code>textArea</code> component.
		 * 
		 * @param data
		 */		
		public function addMessage( data:ChatMessage ):void
		{
			Logger.debug( "Chat.addMessage: " + data );
			
			var addStamp:String = "";
			var text:String = "";
			
			if ( data )
			{
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
					addStamp = StringUtil.replace( "(%s)",
							   DateUtils.createClientStamp() );
				}
				
				// add text to chat
				text = StringUtil.replace( "%s %s", addStamp, data.message );
				
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
			textArea.editable = true;
			textArea.htmlText = "Abc d";
			textArea.setStyle( "textFormat", TextUtils.createTextFormat() );
			textArea.setStyle( "embedFonts", true );
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