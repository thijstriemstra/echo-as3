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
	import com.collab.echo.core.rooms.BaseRoom;
	import com.collab.echo.model.UserVO;
	
	/**
	 * A public '[username] ...' chat message.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class MeChatMessage extends TextChatMessage
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		// XXX: localize
		public static const DOC	: String = "/me [message]";
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param data
		 * @param room
		 */		
		public function MeChatMessage( type:String, data:String, room:BaseRoom )
		{
			super( type, data, room, true, false, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================

		/**
		 * @private 
		 */				
		override protected function parseCommand():void
		{
			var bericht:String = data.substr( 4 );
			
			if ( _sender && bericht.length > 0 )
			{
				execute( bericht );
			}
		}
		
		/**
		 * @param command
		 * @private
		 */		
		override protected function execute( command:String ):void
		{
			var username:String = room.parseUser( _sender ).username;
			
			// add hyperlinks to msg	
			//data = URLUtils.hiliteURLs( command );
			
			message = '<font color="#1B701F"><b>' + username + ' ' + command + '</b></font>';
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
			return "<MeChatMessage data='" + data + "' />";	
		}
		
	}
}