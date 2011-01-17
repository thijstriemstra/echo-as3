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
package com.collab.echo.controls
{
	import com.collab.cabin.controls.FlashColorPicker;
	import com.collab.echo.events.WhiteboardEvent;
	
	import fl.events.ColorPickerEvent;
	
	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * @eventType com.collab.echo.events.WhiteboardEvent.CHANGE_COLOR
	 */
	[Event(name="changeColor", type="com.collab.echo.events.WhiteboardEvent")]
	
	/**
	 * Whiteboard color picker.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class WhiteboardColorPicker extends FlashColorPicker
	{
		
		/**
		 * Constructor.
		 * 
		 * @param label
		 */		
		public function WhiteboardColorPicker( label:String=null )
		{
			super( label );
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 */		
		override protected function onChangeColor( event:ColorPickerEvent ):void
		{
			super.onChangeColor( event );
			
			var evt:WhiteboardEvent = new WhiteboardEvent( WhiteboardEvent.CHANGE_COLOR );
			evt.color = event.color;
			dispatchEvent( evt );
		}
		
	}
}