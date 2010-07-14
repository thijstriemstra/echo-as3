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
package com.collab.echo.view.hub.whiteboard.display
{
	import com.collab.echo.view.controls.buttons.LabelButton;
	import com.collab.echo.view.display.BaseView;
	
	/**
	 * A shared whiteboard.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class Whiteboard extends BaseView
	{
		internal var participants	: Array;
		//internal var colorPicker	: Colorpicker;
		internal var canvas			: Canvas;
		internal var undoButton		: LabelButton;
		
		/**
		 * Constructor. 
		 */		
		public function Whiteboard()
		{
			super();
		}
		
		override protected function draw():void
		{
			// canvas
			canvas = new Canvas();
			addChild( canvas );
			
			// participants
			participants = [];
			
			var user1:Painter = new Painter();
			participants.push( user1 );
		}
		
	}
}