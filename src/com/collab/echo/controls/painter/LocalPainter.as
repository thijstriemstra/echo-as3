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
package com.collab.echo.controls.painter
{
	import com.collab.echo.controls.tools.DrawingTool;
	import com.collab.echo.model.UserVO;
	
	/**
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class LocalPainter extends Painter
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _tool	: DrawingTool;
		
		/**
		 * Constructor.
		 * 
		 * @param data
		 */		
		public function LocalPainter( data:UserVO=null )
		{
			super( data );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override protected function draw():void
		{
			_tool = new DrawingTool();
			addChild( _tool );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			_tool.x = 0;
			_tool.y = 0;
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _tool );
			
			super.invalidate();
		}

	}
}