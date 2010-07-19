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
	/**
	 * @author Thijs Triemstra
	 */	
	public class TimeOnlineMessage extends TextChatMessage
	{
		/**
		 * Constructor.
		 *  
		 * @param data
		 */		
		public function TimeOnlineMessage( data:String=null )
		{
			super( data );
		}
		
		override protected function parseCommand():void
		{
			// calculate the time the selected user's online
			var userNaam:String = data.substr( 12 );
			execute( userNaam );
		}

		/**
		 * Find out how long user is online.
		 * 
		 * @param message
		 */
		override protected function execute( message:String ):void
		{
			var timestamp	: Boolean 		= true; //getTargetMC().chat.menu_accordion.preferences_mc.timestamp_cb.selected;
			//var clientList 					= getRoomManager().getRoom(AppSettings.fnsid).getClientIDs();
			//var attrList 					= getRemoteClientManager().getAttributeForClients(clientList,null, "username");
			var foundIt		: Boolean 		= false;
			
			// cutoff lines
			//truncateChatField( textArea );
			
			/*
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
			*/
			
			// if the username wasn't found
			if (!foundIt) 
			{
				// add Timestamp
				var addStamp:String = "";
				if (timestamp)
				{
					addStamp = createClientStamp();
				}
				
				//textArea.htmlText += addStamp + " <b>Username not found.</b>";
				//textArea.verticalScrollPosition = textArea.maxVerticalScrollPosition;
			}
		}
		
		override public function toString():String
		{
			return "<TimeOnlineMessage data='" + data + "' />";	
		}
		
	}
}