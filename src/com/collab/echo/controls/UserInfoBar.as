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
package com.collab.echo.controls
{
	import com.collab.cabin.core.UIComponent;
	import com.collab.cabin.display.util.StyleDict;
	
	import flash.display.Shape;
	
	/**
	 * User info bar.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class UserInfoBar extends UIComponent
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * 
		 */		
		protected var background	: Shape;
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 */		
		public function UserInfoBar( width:Number=0, height:Number=0 )
		{
			super( width, height );
			show();
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/*
		// show rank icon
		newVideo.screen.header_mc.gotoAndStop(rank);
		
		// show trivia icon
		if (trivia == "true")
		{
		newVideo.screen.header_mc.trivia_icon._visible = true;
		}
		else
		{
		newVideo.screen.header_mc.trivia_icon._visible = false;
		}
		
		// admin or mod
		if (_root.userMode == "guest")
		{
		newVideo.screen.header_mc.kick_icon._visible = false;
		}
		else
		{
		newVideo.screen.header_mc.kick_icon._visible = true;
		}
		
		if ( isSelf() )
		{
		// Hide the pm button 
		newVideo.screen.header_mc.pm_mc._visible = false;
		newVideo.screen.header_mc.kick_icon._visible = false;
		}
		*/
		
		/*
		// show rank icon
		newVideo.screen.header_mc.gotoAndStop(rank);
		
		// admin or mod
		if (_root.userMode == "guest")
		{
		newVideo.screen.header_mc.kick_icon._visible = false;
		}
		else
		{
		newVideo.screen.header_mc.kick_icon._visible = true;
		}
		
		if ( isSelf() )
		{
		// Hide the pm button 
		newVideo.screen.header_mc.pm_mc._visible = false;
		newVideo.screen.header_mc.kick_icon._visible = false;
		}
		*/
		
		/**
		 * @private 
		 */		
		override protected function draw():void
		{
			// background
			background = new Shape();
			with ( background.graphics )
			{
				lineStyle( 1, StyleDict.GREY3, 1 );
				beginFill( StyleDict.WHITE, 1 );
				drawRect( 0, 0, viewWidth, viewHeight );
				endFill();
			}
			addChild( background );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// background
			background.x = 0;
			background.y = 0;
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( background );
			
			super.invalidate();
		}
		
	}
}