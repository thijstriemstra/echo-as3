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
	 * @author Thijs Triemstra
	 */	
	public class KickMessage extends TextChatMessage
	{
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param data
		 * @param presence
		 */		
		public function KickMessage( type:String, data:String, presence:PresenceProxy )
		{
			super( type, data, presence, false, true, true, true );
		}
		
		override protected function parseCommand():void
		{
			// change the users nickname
			var userName:String = data.substr( 6 );
			execute( userName );
		}
		
		override public function toString():String
		{
			return "<KickMessage data='" + data + "' />";	
		}
		
	}
}