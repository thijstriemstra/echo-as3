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
package com.collab.echo.core.rooms
{
	import com.collab.echo.model.UserVO;
	
	/**
	 * Interface for a room.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public interface IRoom
	{
		/**
		 * Adds a new occupant to the room.
		 * 
		 * @param client
		 */		
		function addOccupant( client:UserVO ):void;
		
		/**
		 * Remove an existing occupant from the room.
		 *
		 * @param client
		 */
		function removeOccupant( client:UserVO ):void;
		
		/**
		 * Joined the room.
		 * 
		 * @param client
		 */		
		function joinedRoom( client:UserVO ):void;
		
		/**
		 * Total clients in room updated.
		 * 
		 * @param total
		 */		
		function numClients( total:int ):void;
		
		/**
		 * Client's attribute updated.
		 * 
		 * @param client
		 * @param attr
		 */		
		function clientAttributeUpdate( client:UserVO, attr:Object ):void;
	}
	
}