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
	import com.collab.echo.model.proxy.PresenceProxy;

	/**
	 * Find out how long a user has spent online, by username.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class TimeOnlineMessage extends TextChatMessage
	{
		/**
		 * Constructor.
		 *  
		 * @param type
		 * @param data
		 * @param presence
		 */		
		public function TimeOnlineMessage( type:String, data:String,
										   presence:PresenceProxy=null )
		{
			super( type, data, presence, false, true, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Find out how long user is online. 
		 */		
		override protected function parseCommand():void
		{
			//var clientList 					= getRoomManager().getRoom(AppSettings.fnsid).getClientIDs();
			//var attrList 					= getRemoteClientManager().getAttributeForClients(clientList,null, "username");
			var foundIt		: Boolean 		= false;
			var userNaam:String = data.substr( 12 );
			
			/*
			for (var i:int = 0; i < attrList.length; i++) 
			{
				var clientName:String = attrList[i].value.toLowerCase();
				
				// give user generic name
				if (clientName == undefined)
				{
					clientName = "user"+attrList[i].clientID;
				}
			
				if (clientName == userNaam.toLowerCase())
				{
					// Invoke the function on the client.
					//invokeOnClient("sendTimer", attrList[i].clientID, userNaam);
					
					foundIt = true;
					break;
				}
			}
			*/
			
			// if the username wasn't found
			if (!foundIt) 
			{
				data = " <b>Username not found.</b>";
			}
			
			execute( data );
		}

		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		override public function toString():String
		{
			return "<TimeOnlineMessage data='" + data + "' local='" + local + "' />";	
		}
		
	}
}