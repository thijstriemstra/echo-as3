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
package com.collab.echo.controls.tools
{
	import com.collab.cabin.core.UIComponent;
	
	/**
	 * A tool used to draw a shape, stroke or fill.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class DrawingTool extends UIComponent
	{
		/**
		 * @see com.collab.echo.controls.tools.DrawingModes DrawingModes 
		 */		
		public var mode		: String;
		
		/**
		 * @see com.collab.echo.controls.tools.DrawingToolTypes DrawingToolTypes
		 */		
		public var type		: String;
		
		/**
		 * Radius of the tool's paint area. 
		 */		
		public var size		: int;
		
		/**
		 * Color of the tool's ink. 
		 */		
		public var color	: uint;
		
		/**
		 * Constructor. 
		 */		
		public function DrawingTool( mode:String=null, type:String=null )
		{
			this.mode = mode;
			this.type = type;
			
			super();
		}
		
		/**
		 * @private 
		 * @return 
		 */		
		override public function toString():String
		{
			return "<DrawingTool mode='" + mode + "' type='" + type + "' />";
		}
		
	}
}