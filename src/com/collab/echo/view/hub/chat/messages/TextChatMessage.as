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
package com.collab.echo.view.hub.chat.messages
{
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.view.hub.chat.events.ChatMessageEvent;

	/**
	 * Simple text chat message.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class TextChatMessage extends BaseChatMessage
	{
		/**
		 * Constructor.
		 *  
		 * @param type
		 * @param data
		 * @param includeSelf
		 * @param local
		 * @param privateMessage
		 * @param append
		 */		
		public function TextChatMessage( type:String=null, data:String=null, includeSelf:Boolean=false,
										 local:Boolean=false, privateMessage:Boolean=false,
										 append:Boolean=true )
		{
			super( type, data, includeSelf, local, privateMessage, append );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		override protected function parseCommand():void
		{
			// check it's a private message
			parsePrivateMessage();
			
			execute( data );
		}
		
		/**
		 * @param command
		 */		
		override protected function execute( command:String ):void
		{
			/*
			Logger.debug( "TextChatMessage.execute: " + command + " (private: " +
						  privateMessage + ", local: " + local + ")" );
			*/
			
			// XXX: this should come from a populated UserVO
			var username:String = sender.getAttribute( UserVO.USERNAME );
			
			// use the client id as a user name if the user hasn't set a name.
			if ( username == null )
			{
				username = "user" + sender.getClientID();
			}
			
			// add hyperlinks to msg	
			//data = hiliteURLs( command );
			
			if ( local )
			{
				// local message
				message = '<font color="#990000"><b>' + username + ': </b>' + command + '</font><br/>';
			}
			else
			{
				// remote message
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
				*/
				
				message = "<b>"+ username + ": </b>" + command;
			}
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		override public function load():void
		{
			//var logMessage_pc:PendingCall = getTargetMC().mainService.logMessage(username, msg, getTargetMC().ipaddress, 1); 
			//logMessage_pc.responder = new RelayResponder(this, "logMessage_Result", "onCategoryFault" );
			
			// Send the message to the namespace.
			//invokeOnNamespace("displayMessage", AppSettings.appNamespaceID, true, safeMsg);
			
			//Logger.debug( "TextChatMessage.load: " + this );
			
			// XXX: dispatch after async completed
			var evt:ChatMessageEvent = new ChatMessageEvent( ChatMessageEvent.LOAD_COMPLETE );
			evt.data = this;
			dispatchEvent( evt );
		}
		
		override public function toString():String
		{
			return "<TextChatMessage data='" + data + "' local='" + local + "' type='" + type + "' />";	
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * XXX: probably needs to be determined outside the message.
		 * 
		 * @param msg
		 */		
		internal function parsePrivateMessage():void
		{
			// check it's a private message
			var msgsplit:Array = data.substr( 5 ).split( " : ", 2 );
			var userName:String = msgsplit[ 0 ];
			var message:String = msgsplit[ 1 ];
			
			// if its not an empty message
			if ( message && message.length > 0 )
			{
				privateMessage = true;
			}
			
			// lookup username			
			var foundIt:Boolean = findUserName( userName );
			
			/*
			// if the username wasnt found
			if ( foundIt.clientID == undefined )
			{
				textArea.htmlText += addStamp + " <b>Username not found.</b>";
				inputField.text = bericht;
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
			*/
			
			// empty message
			//textArea.htmlText += addStamp + " <b>Please fill in a message.</b>";
		
			//textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
		}
		
		/**
		 * Look up the clientID and userName of a selected client.
		 */
		internal function findUserName( userName:String ):Object
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
		
		/**
		 * Hilite the urls in a message
		 */
		internal function hiliteURLs( msg:String ):String
		{
			//+
			//escape all <
			//-
			var escaped:String = "";
			var ltPos:Number = msg.indexOf("<");
			while (ltPos != -1) {
				escaped = msg.substring(0, ltPos) + "&lt;" + msg.substring(ltPos+1,msg.length);
				//trace ("escaped: "+escaped);
				msg = escaped;
				ltPos = msg.indexOf("<");
			}
			
			//+
			//escape all >
			//-
			var escaped:String = "";
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