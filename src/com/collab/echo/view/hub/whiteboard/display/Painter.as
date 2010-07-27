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
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.hub.whiteboard.tools.DrawingTool;
	import com.collab.echo.view.hub.whiteboard.tools.Pencil;
	
	/**
	 * A participant of the shared whiteboard.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class Painter extends BaseView
	{
		internal var user	: UserVO;
		internal var tool	: DrawingTool;
		
		/**
		 * Constructor. 
		 */		
		public function Painter()
		{
			super();
		}
		
		override protected function draw():void
		{
			tool = new Pencil();
			addChild( tool );
		}
		
	}
}