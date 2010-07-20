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
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.view.hub.chat.factory.ChatMessageTypes;

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
										   presence:PresenceProxy )
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
			var username:String = data.substr( ChatMessageTypes.TIME_ONLINE.length + 2 );
			var id:String = username.substr( 4 );
			var time:Number;
			var user:*;
			
			if ( username )
			{
				user = presence.getClientByAttribute( UserVO.USERNAME, username );
			}
			
			// if the username wasn't found
			if ( user == null ) 
			{
				if ( username.length > 4 )
				{
					user = presence.getClientById( id );
				}
				
				if ( user )
				{
					time = user.getConnectTime();
				}
				else
				{
					// XXX: localize
					data = " <b>Username not found.</b>";
				}
			}
			else
			{
				time = user.getConnectTime();
			}
			
			if ( time > 0 )
			{
				var userDate:Date = new Date( time );
				var now:Date = new Date();
				var ms:int = now.valueOf() - userDate.valueOf();
				var minutes:Number = Math.floor( ms / 60000 );
				var seconds:Number = Math.floor(( ms - ( minutes * 60000 )) / 1000 );
				var totalHours:Number;
				var hours:Number;
				
				// if its longer than an hour
				if ( minutes >= 60 )
				{
					totalHours = minutes / 60;
					hours = Math.floor( totalHours );
					minutes = Math.floor( 60 * ( totalHours - hours ));
					
					// XXX: localize
					data = "<b>" + username + " has been online for " + hours + " hours, " +
						   minutes + " minutes and " + seconds + " seconds.</b>";
				} 
				else 
				{
					data = "<b>" + username + " has been online for " + minutes +
						   " minutes and " + seconds + " seconds.</b>";
				}
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