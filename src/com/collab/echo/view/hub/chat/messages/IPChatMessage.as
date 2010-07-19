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
	 * Check the IP address for a client by username.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class IPChatMessage extends TextChatMessage
	{
		/**
		 * Constructor.
		 *  
		 * @param type
		 * @param data
		 */		
		public function IPChatMessage( type:String, data:String )
		{
			super( type, data, false, true, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		override protected function parseCommand():void
		{
			// the username
			var username:String = data.substr( 4 );
			
			// XXX: check if username exists and get it's client object
			
			// retrieve the IP address for the client
			var ipaddress:String = sender.getIP();
			
			data = "<b>IPAddress for " + username + ": "+ ipaddress +" </b>";
			
			// get the users ip
			execute( data );
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