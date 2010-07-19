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
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.display.util.DrawingUtils;
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.hub.chat.events.ChatEvent;
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
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var textArea						: TextArea;
		protected var messageHistory				: Array;
		protected var inputField					: ChatInputField;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
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
		 * @param message
		 */		
		public function addMessage( message:String ):void
		{
			// Retrieve the username for the client that sent the message.
			var username		: String 		= "user"; //remoteuser.getAttribute(null, "username");
			//var rank			: String 		= remoteuser.getAttribute(null, "rank");
			var chatMax			: Number 		= textArea.maxVerticalScrollPosition;
			var messageSound	: Boolean		= true; //getTargetMC().chat.menu_accordion.preferences_mc.messageSound_cb.selected;
			var timestamp		: Boolean 		= true; //getTargetMC().chat.menu_accordion.preferences_mc.timestamp_cb.selected;
			
			//var messageGeluid:Sound = new Sound();
			//messageGeluid.attachSound("messageGeluid");
			
			// Use the client id as a user name if the user hasn't set a name.
			//if (username == null) {
			//	username = "user" + clientID;
			//}
			
			// cutoff lines
			truncateChatField( textArea );
			
			// add Timestamp
			var addStamp:String = "";
			if (timestamp)
			{
				//addStamp = createClientStamp();
			}
			
			// Add the message to chat.
			//if (clientID != getClientID())
			//{	
				// play Sound
				if (messageSound)
				{
					//messageGeluid.start();
				}
				/*
				// add tags for staff 
				if (rank == "admin")
				{
				username = '<font color="#1D5EAB">'+username+'</font>';
				}
				else if (rank == "moderator")
				{
				username = '<font color="#1892AF">'+username+'</font>';
				}
				
					// print external message
					textArea.htmlText += addStamp + " <b>"+ username + ": </b>" + msg + "<br>";
				*/
				//}
				//else
				//{
					// internal message
					textArea.htmlText +=  addStamp + ' <font color="#990000"><b>' + username + ': </b>' + message + '</font><br>';
				//}
				
				textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
			//}
		}
		
		/**
		 * @param message
		 * @return 
		 */		
		public function joinMessage( message:String ):void
		{
			var timestamp		: Boolean 		= true; //getTargetMC().chat.menu_accordion.preferences_mc.timestamp_cb.selected;
			var messageSound	: Boolean 		= true; //getTargetMC().chat.menu_accordion.preferences_mc.messageSound_cb.selected;
			//var userGeluid		: Sound 		= new Sound();
			//userGeluid.attachSound("userGeluid");
			
			// cutoff lines
			truncateChatField( textArea );
			
			// add Timestamp
			var addStamp:String = "";
			if (timestamp)
			{
				//addStamp = createClientStamp();
			}
			
			// play sound for incoming user
			if (messageSound)
			{
				//userGeluid.start();
			}
			
			textArea.htmlText += addStamp + " " + message;
			textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}
		
		/**
		 * Send message to all clients in the room.
		 * 
		 * @param msg
		 */
		public function sendMessage( msg:String ): void
		{
			trace("Chat.sendMessage( " + msg + " )" );
			
			// only send the message if there's text
			if ( msg.length > 0 )
			{
				// update history
				updateHistory( msg );
				
				// YAH
				
				// scroll the chat txt
				textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
			}
		}
		
		/**
		 * Look up the clientID and userName of a selected client.
		 */
		protected function findUserName (userName:String):Object
		{
			var foundIt:Object 		= new Object();
			var clientList:Array=[];// 		= getRoomManager().getRoom(AppSettings.fnsid).getClientIDs();
			var attrList:Array=[];// 		= getRemoteClientManager().getAttributeForClients(clientList,null, "username");
			
			for (var i:int = 0; i < attrList.length; i++) 
			{
				var clientName:String = attrList[i].value.toLowerCase();
				
				// give user generic name
				if (clientName == null)
				{
					clientName = "user"+attrList[i].clientID;
				}
				
				// find other name
				if (clientName == userName.toLowerCase()) {
					foundIt.clientID = attrList[i].clientID;
				}
				/*
				if (attrList[i].clientID == getClientID()) {
					foundIt.myName = attrList[i].value;
					foundIt.myID = attrList[i].clientID;
				}
				*/
			}
			
			// if the username wasnt found
			if (foundIt.clientID == undefined)
			{
				return undefined;
			} 
			else 
			{
				return foundIt;
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