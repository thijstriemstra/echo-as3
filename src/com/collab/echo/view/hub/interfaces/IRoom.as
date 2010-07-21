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
package com.collab.echo.view.hub.interfaces
{
	import com.collab.echo.model.vo.UserVO;

	/**
	 * @author Thijs Triemstra
	 */	
	public interface IRoom
	{
		/**
		 * Adds a new occupant to the <code>Room</code>.
		 * 
		 * @param client
		 */		
		function addUser( client:UserVO ):void;
		
		/**
		 * Removes an existing occupant from the <code>Room</code>.
		 * 
		 * @param client
		 */		
		function removeUser( client:UserVO ):void;
		
		/**
		 * Joined the room.
		 * 
		 * @param client
		 */		
		function joinedRoom( client:UserVO ):void;
		
		/**
		 * Total clients in room updated.
		 * 
		 * @param totalClients
		 */		
		function numClients( totalClients:int ):void;
	}
	
}