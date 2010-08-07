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
package com.collab.echo.containers.panels
{
	import com.collab.echo.display.BaseView;
	import com.collab.echo.display.util.DrawingUtils;
	import com.collab.echo.display.util.StyleDict;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * @author Thijs Triemstra
	 */	
	public class Panel extends BaseView
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		protected var background		: Sprite;
		protected var modal				: Boolean;
		protected var modalBack			: Shape;
		protected var offset			: Point;
		
		/**
		 * Constructor.
		 * 
		 * @param modal
		 * @param width
		 * @param height
		 */		
		public function Panel( modal:Boolean=false, width:Number=0, height:Number=0,
							   offset:Point=null )
		{
			super( width, height );
			
			this.modal = modal;
			this.offset = offset;
			
			show();
		}
		
		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================
		
		/**
		 * Instantiate and add child(ren) to display list.
		 * 
		 * @private
		 */	
		override protected function draw() : void
		{
			// modal back
			if ( modal )
			{
				if ( offset == null )
				{
					offset = new Point( -parent.width/2, -parent.height/2 );
				}
				
				modalBack = new Shape();
				modalBack.graphics.beginFill( StyleDict.BLUE1, .2 );
				modalBack.graphics.drawRect( offset.x - 21, offset.y + 45, parent.width, parent.height );
				modalBack.graphics.endFill();
				addChild( modalBack );
			}
			
			// background
			background = DrawingUtils.drawFill( viewWidth, viewHeight,
											    10, StyleDict.YELLOW1, .9 ); 
			addChild( background );
		}
		
		/**
		 * Position child(ren) on display list.
		 * 
		 * @private
		 */
		override protected function layout():void
		{
			// background
			if ( background )
			{
				background.x = 0;
				background.y = 0;
			}
		}
		
		/**
		 * Remove and redraw child(ren).
		 * 
		 * @private
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( background );
			removeChildFromDisplayList( modalBack );
			
			super.invalidate();
		}
		
	}
}