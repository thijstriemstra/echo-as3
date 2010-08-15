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
	import com.collab.echo.core.messages.ChatMessageTypes;
	
	/**
	 * Find the IP address for a client, by username.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class IPChatMessage extends TextChatMessage
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		// XXX: localize
		public static const DOC	: String = "/ip [nickname]   ; get user's IP address.";
		
		/**
		 * Constructor.
		 *  
		 * @param type
		 * @param data
		 * @param presence
		 */		
		public function IPChatMessage( type:String, data:String, presence:* )
		{
			super( type, data, presence, false, true, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override protected function parseCommand():void
		{
			// the username
			var username:String = data.substr( ChatMessageTypes.IP.length + 2 );
			
			// retrieve the IP address for the client by username
			var ip:String;
			
			try
			{
				ip = presence.getIPByUserName( username );
			}
			catch ( e:TypeError )
			{
			}
			finally
			{
				// XXX: localize
				if ( ip == null )
				{
					ip = "Username not found.";
				}
			}
			
			data = "<b>IP address for " + username + ": "+ ip +" </b>";
			
			// get the users ip
			execute( data );
		}
		
		/**
		 * @private
		 * @param command
		 */		
		override protected function execute( command:String ):void
		{
			message = command;
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		override public function toString():String
		{
			return "<IPChatMessage data='" + data + "' local='" + local + "' />";	
		}
		
	}
}