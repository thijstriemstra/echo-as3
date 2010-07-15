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
package com.collab.echo.view.events
{
	import flash.events.Event;
	
	/**
	 * @author Thijs Triemstra
	 */	
	public class BaseRoomEvent extends Event
	{
		public static const JOIN_RESULT			: String = "joinResult";
		public static const OCCUPANT_COUNT		: String = "occupantCount";
		public static const ADD_OCCUPANT		: String = "addOccupant";
		public static const REMOVE_OCCUPANT		: String = "removeOccupant";
		public static const ATTRIBUTE_UPDATE	: String = "attributeUpdate";
		
		public var data 	: *;
		
		/**
		 * Constructor.
		 *  
		 * @param type
		 * @param data
		 */		
		public function BaseRoomEvent( type:String, data:* )
		{
			super( type, false, true );
			this.data = data;
		}
	}
}