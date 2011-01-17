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
package com.collab.echo.events
{
	import flash.events.Event;
	
	// XXX: rename to HubEvent
	
	/**
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class CommunicationPanelEvent extends Event
	{
		internal static const NAME		: String = "CommunicationPanelEvent";
		public static const EXPAND		: String = NAME + "_expand";
		public static const COLLAPSE	: String = NAME + "_collapse";
		
		/**
		 * Constructor.
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */		
		public function CommunicationPanelEvent( type:String, bubbles:Boolean=false,
												 cancelable:Boolean=false )
		{
			super( type, bubbles, cancelable );
		}
		
		override public function toString():String
		{
			return "<CommunicationPanelEvent type='" + type + "' />";
		}
		
	}
}