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
package com.collab.echo.core
{
	import com.collab.echo.view.hub.chat.messages.BaseChatMessage;

	/**
	 * Interface for a chat room.
	 * 
	 * @author Thijs Triemstra
	 */	
	public interface IChatRoom extends IRoom
	{
		/**
		 * Add a message to the chat room.
		 * 
		 * @param data
		 */		
		function addMessage( data:BaseChatMessage ):void;
	}
	
}