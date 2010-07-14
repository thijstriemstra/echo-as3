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
package com.collab.echo.view.hub.whiteboard.tools
{
	/**
	 * Various drawing modes used by the whiteboard tools (<code>Pencil<code>,
	 * <code>PaintBucket</code>, etc).
	 * 
	 * @see com.collab.echo.view.hub.whiteboard.tools.DrawingTool DrawingTool
	 * 
	 * @author Thijs Triemstra
	 */	
	public class DrawingModes
	{
		public static const SHAPE		: String = "shape";		// shape tool
		public static const STROKE		: String = "stroke";    // pencil
		public static const FILL		: String = "fill";		// paint bucket
		public static const ERASE		: String = "erase";		// eraser
	}
}