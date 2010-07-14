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
package com.collab.echo.model.business.events
{
	import flash.events.Event;
	
	/**
	 * AMF loader event.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class LoadAMFEvent extends Event
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		public static const NAME 		: String = "LoadAMFEvent_";
		public static const LOAD	 	: String = NAME + "load";
		public static const COMPLETE	: String = NAME + "complete";
		public static const ERROR		: String = NAME + "error";
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var errorObject		: Object;
		internal var resultObject		: Object;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		public function get error():Object
		{
			return errorObject;
		}
		
		public function set error( val:Object ):void
		{
			errorObject = val;
		}
		
		public function get result():Object
		{
			return resultObject;
		}
		
		public function set result( val:Object ):void
		{
			resultObject = val;
		}
		
		/**
		 * Constructor.
		 *  
		 * @param type
		 */		
		public function LoadAMFEvent( type:String )
		{
			super( type, false, true );
		}
		
		override public function toString():String
		{
			return "<LoadAMFEvent type='" + type + "'/>";
		}
		
	}
}