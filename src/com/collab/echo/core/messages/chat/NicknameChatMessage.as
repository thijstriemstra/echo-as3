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
	 * Change the user's nickname.
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
		public static const DOC			: String = "/nick [nickname]   ; change your nickname.";
		
		// XXX: move to, and get from, a central place
		private var maxChars			: int = 200;
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param data
		 * @param room
		 */		
		public function NicknameChatMessage( type:String, data:String, room:BaseRoom )
		{
			super( type, data, room, false, true, false, true );
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
			
			if ( userName.length > 0 && _sender && _receiver )
			{
				execute( userName );
			}
		}
		
		/**
		 * Sets the username attribute for this client.
		 * 
		 * @private 
		 * @param command
		 */		
		override protected function execute( command:String ):void
		{
			// XXX: perhaps move to room.self
			//var user_SO:SharedObject = SharedObject.getLocal("collab");
			var username:String = command;
			
			trace("NicknameChange.username: " + username );
			
			// XXX: eliza thing: reserved usernames
			if ( username.length > 0 && username.toLowerCase().indexOf( "eliza" ) == -1 &&
				 username.length <= maxChars )
			{
				// XXX: change name in view
				//username_txt.text = userNaam;
				//user_SO.data.username = username;
				//preferences.username = username;
				
				// update local username client attribute
				room.self.setAttribute( UserVO.USERNAME, username, null, true, true, false );

				// XXX: localize
				message = "<b>Successfully updated nickname to '" + username + "'.</b>";
			}
			else
			{
				message = "<b>Nickname '" + username + "' already being used.</b>";
			}
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