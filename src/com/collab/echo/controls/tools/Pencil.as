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
package com.collab.echo.controls.tools
{
	/**
	 * Tool used to draw strokes.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class Pencil extends DrawingTool
	{
		public function Pencil()
		{
			super( DrawingModes.STROKE, DrawingToolTypes.PENCIL );
		}
		
	}
}