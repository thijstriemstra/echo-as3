/*
Echo project.

Copyright (C) 2003-2011 Collab

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
	import com.collab.echo.core.rooms.BaseRoom;
	import com.collab.echo.model.UserVO;
	
	/**
	 * Find out how long a user has spent online, by username.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class TimeOnlineMessage extends TextChatMessage
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		// XXX: localize
		public static const DOC	: String = "/timeOnline [nickname]  ; find out how long the user has been online.";
		
		/**
		 * Constructor.
		 *  
		 * @param type
		 * @param data
		 * @param room
		 */		
		public function TimeOnlineMessage( type:String, data:String, room:BaseRoom )
		{
			super( type, data, room, false, true, false, true );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Find out how long user is online. 
		 * 
		 * @private
		 */		
		override protected function parseCommand():void
		{
			var username:String = data.substr( ChatMessageTypes.TIME_ONLINE.length + 2 );
			var id:String = username.substr( 4 );
			var time:Number;
			var user:*;
			
			if ( _receiver && _sender && username )
			{
				try
				{
					user = room.getClientByAttribute( UserVO.USERNAME, username );
				}
				catch ( e:TypeError )
				{
				}
				finally
				{
					// if the username wasn't found
					if ( user == null ) 
					{
						if ( username.length > 4 )
						{
							try
							{
								user = room.getClientById( id );
							}
							catch ( e:TypeError ) {}
						}
						
						if ( user )
						{
							time = user.getConnectTime();
						}
						else
						{
							// XXX: localize
							data = " <b>Username '" + username + "' not found.</b>";
						}
					}
					else
					{
						time = user.getConnectTime();
					}
				}
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
			return "<TimeOnlineMessage data='" + data + "' local='" + local + "' />";	
		}
		
	}
}