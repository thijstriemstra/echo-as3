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
package com.collab.echo.view.controls.buttons
{
	import com.collab.echo.view.display.util.StyleDict;
	
	import flash.events.MouseEvent;
	
	/**
	 * Button with bold label and solid fill background.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class SolidFillButton extends LabelButton
	{
		/**
		 * Constructor.
		 * 
		 * @param width
		 * @param fontSize
		 * @param textColor
		 * @param backgroundColor
		 * @param backgroundAlpha
		 */		
		public function SolidFillButton( width:Number=0, fontSize:int=15,
										 textColor:uint=StyleDict.WHITE,
										 backgroundColor:uint=StyleDict.BLACK,
										 backgroundAlpha:Number=1)
		{
			super( width, fontSize, textColor, backgroundColor, backgroundAlpha,
				   20, 5, 1, true );
		}
		
		/**
		 * @param event
		 */		
		override protected function onMouseOver( event:MouseEvent ):void
		{
		}
		
		/**
		 * @param event
		 */		
		override protected function onMouseOut( event:MouseEvent ):void
		{
		}
		
	}
}