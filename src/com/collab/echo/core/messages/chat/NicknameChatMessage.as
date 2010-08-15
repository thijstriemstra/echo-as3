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
package com.collab.echo.core.messages.chat
{
	/**
	 * Change the users nickname.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class NicknameChatMessage extends TextChatMessage
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		// XXX: localize
		public static const DOC	: String = "/nick [nickname]   ; change your nickname.";
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param data
		 */		
		public function NicknameChatMessage( type:String, data:String )
		{
			super( type, data, false, true, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override protected function parseCommand():void
		{
			var userName:String = data.substr( 6 );
			
			if ( userName.length > 0 )
			{
				// change name in panel
				//username_txt.text = userNaam;
				
				// send change to union
				//setName();
			}
			
			execute( userName );
		}
		
		/**
		 * Sets the username attribute for this client.
		 */
		public function setName ():void
		{
			/*
			var clientList 						= getRoomManager().getRoom(AppSettings.fnsid).getClientIDs();
			var attrList 						= getRemoteClientManager().getAttributeForClients(clientList,null, "username");
			var preferences	: MovieClip 		= getTargetMC().chat.menu_accordion.preferences_mc;
			var user_SO		: SharedObject 		= SharedObject.getLocal("collab");
			var msg			: String 			= preferences.username_txt.text;
			
			// check for duplicate usernames
			for(var i = 0; i < attrList.length; i++) {
				// if the username is the same but not my own
				var exUserName = attrList[i].value.toLowerCase();
				var exClientID = attrList[i].clientID;
				
				if (msg.toLowerCase() == exUserName && exClientID != getClientID()) {
					msg = "";
					break;
				}
				//trace("The value of 'username' for client " + attrList[i].clientID + " is: " + attrList[i].value); 
			}
			
			// set name
			if (msg.length > 0 && msg.toLowerCase().indexOf("eliza") == -1 && msg.length <= preferences.username_txt.maxChars) {
				setClientAttribute("username", 
					msg, 
					null, 
					true, 
					false, 
					false);
				
				user_SO.data.username = msg;						  
				preferences.username = msg;
			} else {
				chatMC.chat_txt.text += addStamp + " <b>Nickname already being used.</b>";
				chatMC.chat_txt.vPosition = chatMC.chat_txt.maxVPosition;
			}
			*/
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function toString():String
		{
			return "<NicknameChatMessage data='" + data + "' />";	
		}
		
	}
}