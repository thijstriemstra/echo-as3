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
package com.collab.echo.core.messages
{
	/**
	 * The <code>ChatMessageTypes</code> class is an enumeration of constant values
	 * representing different types for a chat message.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class ChatMessageTypes
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		public static const JOIN				: String = "join";
		public static const LEAVE				: String = "leave";
		
		// public
		public static const TEXT 				: String = "text";
		public static const TIME_ONLINE			: String = "timeonline";
		public static const NICK				: String = "nick";
		public static const PRIVATE_MESSAGE		: String = "msg";
		public static const ME					: String = "me";
		public static const CLEAR				: String = "clear";
		public static const HELP1				: String = "help";
		public static const HELP2				: String = "?";
		
		// restricted
		public static const KICK				: String = "kick";
		public static const IP					: String = "ip";
		
		public static const publicTypes			: Array = [ TEXT, TIME_ONLINE, NICK,
															PRIVATE_MESSAGE, ME,
															CLEAR, HELP1, HELP2 ];
	}
}