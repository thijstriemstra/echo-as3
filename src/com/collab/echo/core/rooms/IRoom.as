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
package com.collab.echo.core.rooms
{
	import com.collab.echo.model.vo.UserVO;
	
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
		 * @param args
		 */		
		function addOccupant( args:Array=null ):void;
		
		/**
		 * Removes an existing occupant from the room.
		 * 
		 * @param args
		 */		
		function removeOccupant( args:Array=null ):void;
		
		/**
		 * Joined the room.
		 * 
		 * @param args
		 */		
		function joinedRoom( args:Array=null ):void;
		
		/**
		 * Total clients in room updated.
		 * 
		 * @param args
		 */		
		function numClients( args:Array=null ):void;
	}
	
}