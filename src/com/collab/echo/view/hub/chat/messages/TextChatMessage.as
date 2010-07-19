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
	import org.osflash.thunderbolt.Logger;

	/**
	 * @author Thijs Triemstra
	 */	
	public class TextChatMessage extends BaseChatMessage
	{
		/**
		 * Constructor.
		 *  
		 * @param data
		 */		
		public function TextChatMessage( data:String=null )
		{
			super( data );
		}
		
		override protected function parseCommand():void
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
			
			execute( data );
		}
		
		override protected function execute( message:String ):void
		{
			Logger.debug( "TextChatMessage.execute: " + message + " (private: " + privateMessage + ")" );
			
			// log the message
			//var remoteuser:RemoteClient = getRemoteClientManager().getClient(getClientID());
			var username:String = "";//remoteuser.getAttribute(null, "username");
			
			// Use the client id as a user name if the user hasn't set a name.
			if (username == null)
			{
				//username = "user" + clientID;
			}
			
			//var logMessage_pc:PendingCall = getTargetMC().mainService.logMessage(username, msg, getTargetMC().ipaddress, 1); 
			//logMessage_pc.responder = new RelayResponder(this, "logMessage_Result", "onCategoryFault" );
			
			// add hyperlinks to msg	
			message = hiliteURLs(message);
			
			// The normal message we'll send to the server.
			var safeMsg:String = '<![CDATA[' + message + ']]>';
			
			// Send the message to the namespace.
			//invokeOnNamespace("displayMessage", AppSettings.appNamespaceID, true, safeMsg);
		}
		
		/**
		 * @param msg
		 */		
		protected function parsePrivateMessage( msg:String ):void
		{
			var timestamp:Boolean = true; //getTargetMC().chat.menu_accordion.preferences_mc.timestamp_cb.selected;	
			
			// add Timestamp
			var addStamp:String = "";
			if (timestamp)
			{
				addStamp = createClientStamp();
			}
			
			/*
			// lookup username			
			var foundIt = findUserName(userName);
			
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
		 * Create a client-side timestamp.
		 */
		internal function createClientStamp():String
		{
			var my_date:Date = new Date();
			var theTime:Array = [my_date.getHours(), my_date.getMinutes(), my_date.getSeconds()];
			
			for (var v:int=0; v<theTime.length; v++) {
				if (theTime[v] < 10) {
					theTime[v] = "0" + theTime[v];
				}
			}
			return "(" + theTime[0] + ":" + theTime[1] + ":" + theTime[2] + ")";
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
		
		override public function toString():String
		{
			return "<TextChatMessage data='" + data + "' />";	
		}
		
	}
}