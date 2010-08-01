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
	
	/**
	 * A public '[username] ...' chat message.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class MeChatMessage extends TextChatMessage
	{
		public static const DOC	: String = "/me [message]";
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param data
		 */		
		public function MeChatMessage( type:String, data:String )
		{
			super( type, data, null, true, false, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		override protected function parseCommand():void
		{
			var bericht:String = data.substr( 4 );
			
			if ( bericht.length > 0 )
			{
				execute( bericht );
			}
		}
		
		/**
		 * @param command
		 */		
		override protected function execute( command:String ):void
		{
			// XXX: this should come from a populated UserVO
			var username:String = sender.getAttribute( UserVO.USERNAME );
			
			// Use the client id as a user name if the user hasn't set a name.
			if ( username == null )
			{
				username = "user" + sender.getClientID();
			}
			
			// add hyperlinks to msg	
			//data = hiliteURLs( command );
			
			message = '<font color="#1B701F"><b>' + username + ' ' + command + '</b></font>';
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		override public function toString():String
		{
			return "<MeChatMessage data='" + data + "' />";	
		}
		
	}
}