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
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.util.DateUtils;
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.display.util.DrawingUtils;
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.hub.chat.events.ChatEvent;
	import com.collab.echo.view.hub.chat.messages.BaseChatMessage;
	import com.collab.echo.view.hub.interfaces.IPresence;
	
	import fl.controls.TextArea;
	
	import flash.display.Sprite;
	import flash.system.Capabilities;
	
	/**
	 * Chat.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class Chat extends BaseView implements IPresence
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		internal static const HISTORY_MAX_LENGTH	: int = 20;
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var _background					: Sprite;
		internal var _user							: *;
		internal var _welcomeMessage				: String;
		internal var _sendLabel						: String;
		internal var _playSound						: Boolean;
		internal var _showTimestamp					: Boolean;
		
		//var messageGeluid:Sound = new Sound();
		//messageGeluid.attachSound("messageGeluid");
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var textArea						: TextArea;
		protected var messageHistory				: Array;
		protected var inputField					: ChatInputField;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		public function get playSound():Boolean
		{
			return _playSound;
		}
		public function set playSound( val:Boolean ):void
		{
			_playSound = val;
		}

		public function get showTimestamp():Boolean
		{
			return _showTimestamp;
		}
		public function set showTimestamp( val:Boolean ):void
		{
			_showTimestamp = val;
		}
		
		public function get welcomeMessage()		: String
		{
			return _welcomeMessage;
		}
		public function set welcomeMessage( val:String ):void
		{
			_welcomeMessage = val;
			invalidate();
		}
		
		public function get sendLabel()				: String
		{
			return _sendLabel;
		}
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
		 */		
		public function Chat( width:Number=0, height:Number=0 )
		{
			messageHistory = [];
			_playSound = false;
			_showTimestamp = true;
			
			super( width, height );
			show();
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @param client
		 */		
		public function addUser( client:UserVO ):void
		{
			//Logger.debug( "Chat.addUser: " + client );
			
			// show welcome message for this client
			if ( client.client.isSelf() )
			{
				textArea.htmlText += "<b><FONT COLOR='#000000'>" + getWelcomeLine() +
					                 " " + client.username + "!</FONT></b><br>";
				// XXX: localize
				textArea.htmlText += "<b><FONT COLOR='#4F4F4F'>Chat is now active...</FONT></b><br>";
				textArea.htmlText += "<b><FONT COLOR='#4F4F4F'>Type /help for options.</FONT></b><br>";
			}
		}
		
		/**
		 * @param client
		 */		
		public function removeUser( client:UserVO ):void
		{
			//Logger.debug( "Chat.removeUser: " + client );
			
			textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}
		
		/**
		 * Add a chat message to the <code>textArea</code>.
		 * 
		 * @param data
		 */		
		public function addMessage( data:BaseChatMessage ):void
		{
			var chatMax			: Number = textArea.maxVerticalScrollPosition;
			var addStamp		: String = "";
			var text			: String = "";
			
			// update history
			updateHistory( data.message );
			
			// play sound
			if ( _playSound )
			{
				//messageGeluid.start();
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
		
		/**
		 * @param message
		 * @return 
		 */		
		public function joinMessage( message:String ):void
		{
			var addStamp		: String = "";
			
			// play sound
			if ( _playSound )
			{
				//messageGeluid.start();
			}
			
			// add timestamp
			if ( _showTimestamp )
			{
				addStamp = DateUtils.createClientStamp();
			}
			
			// append to chat
			textArea.htmlText += addStamp + " " + message;
			
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
			
			//chatMC.currentHistory = chatMC.messageHistory.length;
		}
		
		/**
		 * Instantiate and add child(ren) to display list.
		 */	
		override protected function draw() : void
		{
			// background
			_background = DrawingUtils.drawFill( viewWidth, viewHeight,
												0, StyleDict.GREEN1, 1 ); 
			addChild( _background );
			
			// inputField
			inputField = new ChatInputField( _background.width );
			inputField.addEventListener( ChatEvent.HISTORY_DOWN, onHistoryDown, false, 0, true );
			inputField.addEventListener( ChatEvent.HISTORY_UP, onHistoryUp, false, 0, true );
			inputField.text = _welcomeMessage;
			inputField.buttonLabel = _sendLabel;
			addChild( inputField );
			
			// text
			textArea = new TextArea();
			textArea.setSize( viewWidth, viewHeight - inputField.height ); 
			textArea.condenseWhite = true; 
			textArea.editable = false;
			addChild( textArea );
		}
		
		/**
		 * Position child(ren) on display list.
		 */
		override protected function layout():void
		{
			// background
			_background.x = 0;
			_background.y = 0;
			
			// textArea
			textArea.x = 0;
			textArea.y = 0;
			
			// inputField
			inputField.x = 0;
			inputField.y = textArea.y + textArea.height;
		}
		
		/**
		 * Remove and redraw child(ren).
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _background );
			removeChildFromDisplayList( inputField );
			removeChildFromDisplayList( textArea );
			
			super.invalidate();
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		protected function onHistoryUp( event:ChatEvent ):void
		{
			event.stopImmediatePropagation();
			
			trace( 'onHistoryUp: ' + event );
		}
		
		protected function onHistoryDown( event:ChatEvent ):void
		{
			event.stopImmediatePropagation();
			
			trace( 'onHistoryDown: ' + event );
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * Create a welcome message depending on the nationality.
		 * 
		 * @return
		 */
		internal function getWelcomeLine():String
		{
			var welcome:String = "Welcome";
			
			// XXX: localize
			switch ( Capabilities.language )
			{
				case "fr":
					welcome = "Bienvenue";
					break;
				
				case "de":
					welcome = "Willkommen";
					break;
				
				case "nl":
					welcome = "Welkom";
					break;
				
				case "it":
					welcome = "Benvenuto";
					break;
				
				case "pt":
					welcome = "Boa vinda";
					break;
				
				case "es":
					welcome = "Recepción";
					break;
			}
			
			return welcome;
		}
		
		/**
		 * Trim the chat text field.
		 *  
		 * @param welke
		 * @return 
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
		 * Trim text
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