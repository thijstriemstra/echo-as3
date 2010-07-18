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
	import com.collab.echo.view.hub.chat.factory.ChatMessageTypes;
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
		// INTERNAL VARS
		// ====================================
		
		internal var _background		: Sprite;
		internal var _inputField		: ChatInputField;
		internal var _user				: *;
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var textArea			: TextArea;
		protected var messageHistory	: Array;
		
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
		 * @param message
		 */		
		public function addMessage( message:String ):void
		{
			textArea.htmlText += message;
		}
		
		/**
		 * @param msg
		 */		
		protected function updateHistory( msg:String ):void
		{
			// add message to history list if its not the same as previous
			if ( msg != messageHistory[ messageHistory.length - 1 ])
			{
				// limit the history
				if ( messageHistory.length > 20 )
				{
					messageHistory.shift();
				}
				
				// add message to history
				messageHistory.push( msg );
			}
			
			//chatMC.currentHistory = chatMC.messageHistory.length;
		}
		
		/**
		 * Send message to all clients in the room.
		 */
		public function sendMessage(): void
		{
			// the message typed by the user
			var msg:String = _inputField.text;
			
			// only send the message if there's text
			if ( msg.length > 0 )
			{
				// update history
				updateHistory( msg );
				
				// clear the user input text field
				_inputField.text = "";
				
				switch ( msg )
				{
					case ChatMessageTypes.STATS:
						//getServerStatus();
						break;
					
					case ChatMessageTypes.TIME_ONLINE:
						// calculate the time the selected user's online
						var userNaam:String = msg.substr( 12 );
						timeOnline( userNaam );
						break;
					
					case ChatMessageTypes.NICK:
						// change the users nickname
						var userNaam:String = msg.substr( 6 );
						
						if ( userNaam.length > 0 )
						{
							// change name in panel
							//this.getTargetMC().chat.menu_accordion.preferences_mc.username_txt.text = userNaam;
							
							// send change to Unity
							//setName();
						}
						break;
					
					case ChatMessageTypes.PRIVATE_MESSAGE:
						privateMessage( msg );
						break;
					
					case ChatMessageTypes.ME:
						var bericht  = msg.substr( 4 );
						
						if ( bericht.length > 0 )
						{
							var safeMsg:String = '<![CDATA[' + bericht + ']]>';
							
							// Send the message to the server.
							//invokeOnRoom("meText", "collab.global", true, safeMsg);
							//invokeOnNamespace("meText", AppSettings.appNamespaceID, true, safeMsg);
						}
						break;
					
					case ChatMessageTypes.KICK:
						// change the users nickname
						var userNaam:String = msg.substr(6);
						//kickUser(userNaam);
						break;
					
					case ChatMessageTypes.CLEAR:
						// clear chat txt window
						textArea.htmlText = "<b>Cleared.</b>";
						break;
					
					case ChatMessageTypes.QUOTE:
						// get quote from webservice
						//getTargetMC().getQuote();
						break;
					
					case ChatMessageTypes.IP:
						// the username
						var username:String = msg.substr(4);
						// get the users ip
						//getIP(username);
						break;
					
					case ChatMessageTypes.HELP1:
					case ChatMessageTypes.HELP2:
						textArea.text += "<b>Command List</b><br>";
						textArea.text += "/msg [nickname] : [string]     ; send someone a private message.<br>";
						textArea.text += "/nick [nickname]   ; change your nickname.<br>";
						textArea.text += "/stats    ; FlashCom application bandwidth stats.<br>";
						textArea.text += "/clear     ; clear the text in the chat window.<br>";
						textArea.text += "/timeOnline [nickname]  ; find out how long the user has been online.<br>";
						textArea.text += "/quote    ; random quote from 'famous' people.<br>";
						textArea.text += "/me [message] <br>";
						textArea.text += "/eliza [string]   ; Eliza is a 24/7 psychotherapist.<br>";
						textArea.text += "/alice [message]   ; A.L.I.C.E. is a natural language robot.<br>";
						textArea.text += "/mrtrivia [message]   ; QuizMaster bot.<br>";
						// add staff items
						//if (_root.userMode != "guest")
						//{
							textArea.text += "/ip [nickname]   ; get user's IP address.<br>";
							textArea.text += "/kick [nickname]   ; kick a user.<br>";
						//}
						break;
					
					// APP RELATED
					
					case ChatMessageTypes.TEXT:
						// log the message
						//var remoteuser:RemoteClient = getRemoteClientManager().getClient(getClientID());
						var username:String = "";//remoteuser.getAttribute(null, "username");
						
						// Use the client id as a user name if the user hasn't set a name.
						if (username == undefined)
						{
							//username = "user" + clientID;
						}
						
						//var logMessage_pc:PendingCall = getTargetMC().mainService.logMessage(username, msg, getTargetMC().ipaddress, 1); 
						//logMessage_pc.responder = new RelayResponder(this, "logMessage_Result", "onCategoryFault" );
						
						// add hyperlinks to msg	
						msg = this.hiliteURLs(msg);
						
						// The normal message we'll send to the server.
						var safeMsg:String = '<![CDATA[' + msg + ']]>';
						
						// Send the message to the namespace.
						//invokeOnNamespace("displayMessage", AppSettings.appNamespaceID, true, safeMsg);
				}
				
				// scroll the chat txt
				textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
			}
		}
		
		/**
		 * @param msg
		 */		
		protected function privateMessage( msg:String ):void
		{
			// private message
			var msgsplit:Array = msg.substr(5).split(" : ", 2);
			var userName:String = msgsplit[0];
			var bericht = msgsplit[1];
			var timestamp:Boolean = true; //getTargetMC().chat.menu_accordion.preferences_mc.timestamp_cb.selected;	
			
			// add Timestamp
			if (timestamp)
			{
				var addStamp:String = createClientStamp();
			}
			else
			{
				var addStamp:String = "";
			}
			
			// if its not an empty message
			if (bericht.length > 0)
			{
				// lookup username			
				var foundIt = findUserName(userName);
				
				// if the username wasnt found
				if ( foundIt.clientID == undefined )
				{
					textArea.htmlText += addStamp + " <b>Username not found.</b>";
					_inputField.text = bericht;
				}
				else
				{
					// if youre not sending it to yourself
					if (foundIt.clientID != foundIt.myID)
					{
						// Invoke the function on the other client.
						var safeMsg:String = '<![CDATA[<font color="#B1661D"><b>' + foundIt.myName + ' (private)</b>: ' + bericht + '</font>]]>';
						//invokeOnClient("joinMessage", foundIt.clientID, safeMsg);
						
						// print message on own client
						textArea.text += addStamp + " <font color='#990000'><b>" + foundIt.myName + ' ('+ userName +')</b>: ' + bericht + "</font>";
					}
					else
					{
						textArea.text += addStamp + " <b>Please don't send yourself private messages.</b>";
					}
				}
			}
			else
			{
				// empty message
				textArea.htmlText += addStamp + " <b>Please fill in a message.</b>";
			}
			
			textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}
		
		/**
		 * Displays text sent by a client.
		 *  
		 * @param clientID
		 * @param msg
		 */		
		public function displayMessage( clientID:String, msg:String ):void
		{
			// Retrieve the username for the client that sent the message.
			//var username		: String 		= remoteuser.getAttribute(null, "username");
			//var rank			: String 		= remoteuser.getAttribute(null, "rank");
			var chatMax			: Number 		= textArea.maxVerticalScrollPosition;
			var messageSound	: Boolean		= true; //getTargetMC().chat.menu_accordion.preferences_mc.messageSound_cb.selected;
			var timestamp		: Boolean 		= true; //getTargetMC().chat.menu_accordion.preferences_mc.timestamp_cb.selected;
			
			//var messageGeluid:Sound = new Sound();
			//messageGeluid.attachSound("messageGeluid");
			
			// if you are not ignoring this client's messages
			//if (!ignoreClient) 
			//{
				// Use the client id as a user name if the user hasn't set a name.
				//if (username == undefined) {
				//	username = "user" + clientID;
				//}
				
				// cutoff lines
				truncateChatField( textArea );
				
				// add Timestamp
				var addStamp:String = "";
				if (timestamp)
				{
					var addStamp:String = createClientStamp();
				}
				
				// Add the message to chat.
				//if (clientID != getClientID())
				//{	
					// play Sound
					if (messageSound)
					{
						//messageGeluid.start();
					}
					
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
				//}
				//else
				//{
					// internal message
					textArea.htmlText +=  addStamp + ' <font color="#990000"><b>' + username + ': </b>' + msg + '</font><br>';
				//}
				
				// Scroll the incoming_txt text field to the bottom.
				textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
				//textArea.scroll = textArea.maxscroll;
			//}
		}
		
		/**
		 * Broadcast a txt message to the chat.
		 *  
		 * @param clientID
		 * @param msg
		 * @return 
		 */		
		public function joinMessage( clientID:String, msg:String ):void
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
				addStamp = createClientStamp();
			}
			
			// play sound for incoming user
			if (messageSound)
			{
				userGeluid.start();
			}
			
			textArea.htmlText += addStamp + " " + msg;
			textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}
		
		/**
		 * Broadcast the quote of the day.
		 */
		public function addQuote (msg:String):void
		{
			// Send the message to the server.
			//invokeOnRoom("meText", AppSettings.fnsid, true, msg);
		}
		
		/**
		 * Recieve special message!
		 */
		public function meText (clientID:String, msg:String):void
		{
			// Retrieve the username for the client that sent the message.
			//var remoteuser	: RemoteClient 	= getRemoteClientManager().getClient(clientID);
			//var username	: String 		= remoteuser.getAttribute(null, "username");
			
			// cutoff lines
			truncateChatField(textArea);
			
			textArea.htmlText +=  '<font color="#1B701F"><b>' + username + ' ' + msg + '</b></font><br>'
			textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}
		
		/**
		 * Find out how long user is online.
		 */
		public function timeOnline (userName:String):void
		{
			var timestamp	: Boolean 		= true; //getTargetMC().chat.menu_accordion.preferences_mc.timestamp_cb.selected;
			//var clientList 					= getRoomManager().getRoom(AppSettings.fnsid).getClientIDs();
			//var attrList 					= getRemoteClientManager().getAttributeForClients(clientList,null, "username");
			var foundIt		: Boolean 		= false;
			
			// cutoff lines
			truncateChatField( textArea );
			
			for (var i:int = 0; i < attrList.length; i++) 
			{
				var clientName:String = attrList[i].value.toLowerCase();
				
				// give user generic name
				if (clientName == undefined)
				{
					clientName = "user"+attrList[i].clientID;
				}
				
				if (clientName == userName.toLowerCase())
				{
					// Invoke the function on the client.
					//invokeOnClient("sendTimer", attrList[i].clientID, userName);
					
					foundIt = true;
					break;
				}
			}
			
			// if the username wasn't found
			if (!foundIt) 
			{
				// add Timestamp
				var addStamp:String = "";
				if (timestamp)
				{
					addStamp = createClientStamp();
				}
				
				textArea.htmlText += addStamp + " <b>Username not found.</b>";
				textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
			}
		}
		
		/**
		 * Create a client-side timestamp.
		 */
		public function createClientStamp():String
		{
			var my_date:Date = new Date();
			var theTime:Array = [my_date.getHours(), my_date.getMinutes(), my_date.getSeconds()];
			
			for (var v=0; v<theTime.length; v++) {
				if (theTime[v] < 10) {
					theTime[v] = "0" + theTime[v];
				}
			}
			return "(" + theTime[0] + ":" + theTime[1] + ":" + theTime[2] + ")";
		}
		
		/**
		 * Trim the chat text field.
		 *  
		 * @param welke
		 * @return 
		 */		
		public function truncateChatField( welke:String ):void
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
		public function truncateTxt(welke:String):void
		{
			var maxChars:Number = 15000;
			if (welke.text.length > maxChars) 
			{
				var startTrim:Number = welke.text.indexOf('<P ALIGN="LEFT">', 1000);
				welke.text = welke.text.substring(startTrim);
			}
		}
		
		/**
		 * Check the IP address.
		 * 
		 * @param userName
		 */
		public function getIP(userName:String) 
		{
			var timestamp	: Boolean 	= true; //getTargetMC().chat.menu_accordion.preferences_mc.timestamp_cb.selected;
			//var clientList 				= getRoomManager().getRoom(AppSettings.fnsid).getClientIDs();
			//var attrList 				= getRemoteClientManager().getAttributeForClients(clientList,null, "username");
			var foundIt 				= undefined;
			
			for (var i = 0; i < attrList.length; i++)
			{
				var clientName:String = attrList[i].value;
				
				// give user generic name
				if (clientName == undefined) {
					clientName = "user"+attrList[i].clientID;
				}
				
				// find other name
				if (clientName.toLowerCase() == userName.toLowerCase()) {
					foundIt = attrList[i].clientID;
					break;
				}
			}
			
			// add Timestamp
			var addStamp:String = "";
			if (timestamp) 
			{
				addStamp = createClientStamp() + " ";
			} 
			
			// if the username wasnt found
			if ( foundIt == undefined )
			{
				textArea.htmlText += addStamp + " <b>Username not found.</b>";
				
			}
			else
			{
				// Retrieve the IPAddress for the client.
				var ipaddress:String = "";//remoteuser.getAttribute(null, "_IP");
				
				textArea.htmlText += addStamp + "<b>IPAddress for " + clientName + ": "+ ipaddress +" </b>";
			}
			
			chatMC.chat_txt.vPosition = chatMC.chat_txt.maxVPosition;
		}
		
		/**
		 * Look up the clientID and userName of a selected client.
		 */
		public function findUserName (userName:String) 
		{
			var foundIt 		= new Object();
			var clientList 		= getRoomManager().getRoom(AppSettings.fnsid).getClientIDs();
			var attrList 		= getRemoteClientManager().getAttributeForClients(clientList,null, "username");
			
			for (var i = 0; i < attrList.length; i++) 
			{
				var clientName:String = attrList[i].value.toLowerCase();
				
				// give user generic name
				if (clientName == undefined) {
					clientName = "user"+attrList[i].clientID;
				}
				
				// find other name
				if (clientName == userName.toLowerCase()) {
					foundIt.clientID = attrList[i].clientID;
				}
				
				if (attrList[i].clientID == getClientID()) {
					foundIt.myName = attrList[i].value;
					foundIt.myID = attrList[i].clientID;
				}
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
		 * Instantiate and add child(ren) to display list.
		 */	
		override protected function draw() : void
		{
			// background
			_background = DrawingUtils.drawFill( viewWidth, viewHeight,
												0, StyleDict.GREEN1, 1 ); 
			addChild( _background );
			
			// inputField
			_inputField = new ChatInputField( _background.width );
			addChild( _inputField );
			
			// text
			textArea = new TextArea();
			textArea.setSize( viewWidth, viewHeight - _inputField.height ); 
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
			_inputField.x = 0;
			_inputField.y = textArea.y + textArea.height;
		}
		
		/**
		 * Remove and redraw child(ren).
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _background );
			removeChildFromDisplayList( _inputField );
			removeChildFromDisplayList( textArea );
			
			super.invalidate();
		}
		
		/**
		 * Create a welcome message depending on the nationality.
		 * 
		 * @return
		 */
		protected function getWelcomeLine():String
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
		 * Hilite the urls in a message
		 */
		public function hiliteURLs (msg:String):String
		{
			
			//+
			//escape all <
			//-
			var escaped = "";
			var ltPos = msg.indexOf("<");
			while (ltPos != -1) {
				escaped = msg.substring(0, ltPos) + "&lt;" + msg.substring(ltPos+1,msg.length);
				//trace ("escaped: "+escaped);
				msg = escaped;
				ltPos = msg.indexOf("<");
			}
			
			//+
			//escape all >
			//-
			var escaped = "";
			var ltPos = msg.indexOf(">");
			while (ltPos != -1) {
				escaped = msg.substring(0, ltPos) + "&gt;" + msg.substring(ltPos+1,msg.length);
				//trace ("escaped: "+escaped);
				msg = escaped;
				ltPos = msg.indexOf(">");
			}
			
			//+
			//highlight urls
			//-
			var url_begin = msg.indexOf("http:");
			if ( url_begin == -1 )
				url_begin = msg.indexOf("www.");
			
			if ( url_begin == -1 )
				return msg;
			
			var hilited = msg.substring(0, url_begin);
			var url_end = msg.indexOf( " ", url_begin );
			
			var urlstr = "";
			if ( url_end == -1 )
				urlstr = msg.substring(url_begin);
			else
				urlstr = msg.substring(url_begin, url_end);
			
			var urlref = urlstr;
			if ( urlstr.indexOf("www.") == 0 )
				urlref = "http://" + urlstr;
			
			var trailer = "";
			if ( url_end != -1 )
				trailer = this.hiliteURLs( msg.substring(url_end) );
			
			hilited += "<font color=\"#0000FF\"><u><a href=\"" + urlref + "\" target=\"_blank\">" + urlstr + "</a></u></font>" + trailer;
			//hilited += "<font color=\"#0000FF\"><u><a href=\"" + urlstr + "\">" + urlstr + "</a></u></font>" + trailer;
			
			return hilited;
		}

		
	}
}