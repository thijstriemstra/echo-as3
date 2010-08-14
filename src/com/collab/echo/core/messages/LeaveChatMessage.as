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
package com.collab.echo.core.messages
{
	import com.collab.echo.model.UserVO;
	
	/**
	 * Message that is displayed when a remote user left the chat.
	 * 
	 * @author Thijs Triemstra
	 * 
     * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class LeaveChatMessage extends TextChatMessage
	{
		/**
		 * Constructor.
		 *  
		 * @param type
		 * @param data
		 * @param presence
		 */		
		public function LeaveChatMessage( type:String, data:String, presence:* )
		{
			super( type, data, presence, false, true, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		override protected function parseCommand():void
		{
			if ( _sender && _receiver )
			{
				execute( data );
			}
		}
		
		override protected function execute( command:String ):void
		{
			// XXX: this should come from a populated UserVO
			var username:String = _receiver.getAttribute( UserVO.USERNAME );
			var clientID:String = _receiver.getClientID();
			
			// use the client id as a user name if the user hasn't set a name.
			if ( username == null )
			{
				username = "user" + clientID;
			}
			
			/*if ( appClient.rank == "admin" )
			{
				// XXX: localize
				textArea.htmlText += addStamp + " <font color='#1D5EAB'><b>" + appClient.username + " has left.</b></font>";
			}
			else if ( appClient.rank == "moderator" )
			{
				textArea.htmlText += addStamp + " <font color='#1892AF'><b>" + appClient.username + " has left.</b></font>";
			}
			else
			{
			*/
			
			// XXX: localize
			message = "<b>"+ username +" has left.</b>";
		}
		
		override public function toString():String
		{
			return "<LeaveChatMessage data='" + data + "' local='" + local + "' type='" + type + "' />";	
		}
		
	}
}