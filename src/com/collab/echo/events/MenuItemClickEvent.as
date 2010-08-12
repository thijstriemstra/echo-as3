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
package com.collab.echo.events
{
	import flash.events.Event;
	
	/**
	 * Menu item was clicked.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class MenuItemClickEvent extends Event
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		/**
		 * @private 
		 */		
		internal static const NAME	: String = "MenuItemClickEvent_";
		public static const CLICK 	: String = NAME + "click";
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		/**
		 * @private 
		 */		
		internal var index	: int;
		
		/**
		 * @private 
		 */		
		internal var label	: String;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		public function get itemIndex():int
		{
			return index;
		}
		
		public function get itemLabel():String
		{
			return label;
		}
		
		/**
		 * Constructor.
		 *  
		 * @param type
		 * @param index
		 * @param label
		 * @param bubbles
		 * @param cancelable
		 */		
		public function MenuItemClickEvent( type:String, index:int, label:String,
											bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super( type, bubbles, cancelable );
			
			this.index = index;
			this.label = label;
		}
		
		override public function toString():String
		{
			return "<MenuItemClickEvent index='" + index +
				   "' label='" + label + "' />";
		}
		
	}
}