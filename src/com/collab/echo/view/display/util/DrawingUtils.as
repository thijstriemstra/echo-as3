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
package com.collab.echo.view.display.util
{
	import flash.display.GradientType;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * Drawing utilities.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class DrawingUtils
	{
		/**
		 * Draw a solid fill with a corner radius.
		 * 
		 * @param width
		 * @param height
		 * @param cornerRadius
		 * @param color
		 * @param alpha
		 * @return 
		 */		
		public static function drawFill( width:Number, height:Number,
										 cornerRadius:Number=20,
										 color:uint=0xFFFFFF, alpha:Number=1 ):Sprite
		{
			var bg:Sprite = new Sprite();
			bg.alpha = alpha;
			bg.graphics.beginFill( color, StyleDict.BACKGROUND_ALPHA );
			bg.graphics.drawRoundRect( 0, 0, width, height, cornerRadius,
									   cornerRadius );
			bg.graphics.endFill();
			
			return bg;
		}
		
		/**
		 * Draw gradient fill with a corner radius.
		 * 
		 * @param width
		 * @param height
		 * @param radius
		 * @return 
		 */		
		public static function drawGradientFill( width:int, height:int, radius:int ):Shape
		{
			var bg:Shape = new Shape();
			var matr:Matrix = new Matrix();
  			matr.createGradientBox( width, height, 300 );
			bg.graphics.lineStyle( .25, StyleDict.RED1, .2, true, LineScaleMode.NORMAL );
			bg.graphics.beginGradientFill( GradientType.LINEAR, StyleDict.COLORS,
										   StyleDict.ALPHAS, StyleDict.RATIOS, matr );
			bg.graphics.drawRoundRect( 0, 0, width, height, radius, radius );
			bg.graphics.endFill();
			
			return bg;
		}
		
		/**
		 * Draw a horizontal line.
		 * 
		 * @param width
		 * @return 
		 */		
		public static function drawHLine( width:int=10, color:uint=0xFFFFFF, alpha:Number=.2,
										  thickness:Number=.25 ):Shape
		{
			var shape:Shape = new Shape();
			shape.graphics.lineStyle( thickness, color, alpha );
			shape.graphics.lineTo( width, 0 );
			
			return shape;
		}
		
	}
}