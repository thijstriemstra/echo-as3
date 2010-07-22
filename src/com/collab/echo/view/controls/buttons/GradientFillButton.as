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
	
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
		
	/**
	 * Button with bold label and gradient background.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class GradientFillButton extends SolidFillButton
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _allFilters		: Array;
		
		/**
		 * Constructor.
		 * 
		 * @param width
		 * @param fontSize
		 * @param textColor
		 */		
		public function GradientFillButton( width:Number=157, fontSize:int=15,
											textColor:uint=StyleDict.WHITE )
		{
			super( width, fontSize, textColor );
			
			// init vars
			_allFilters = [ getGlowFilter() ];
            alpha = .85;
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		override protected function drawBackground():void
		{
			var w:int = _width;
			var h:int = 28;
			var radius:int = 15;
			var colors:Array = [ StyleDict.PURPLE1, StyleDict.RED1, StyleDict.YELLOW1 ];
			var alphas:Array = [ 1, 1, 1 ];
			var ratios:Array = [ 0, 130, 180 ];

			var matr:Matrix = new Matrix();
	  		matr.createGradientBox( w, h, 300 );
	  		
	  		background = new Shape();
			background.graphics.beginGradientFill( GradientType.LINEAR, colors,
												   alphas, ratios, matr );
			background.graphics.drawRoundRect( 0, 0, w, h, radius, radius );
			background.graphics.endFill();
			addChild( background );
		}
		
		override protected function layout():void
		{
			super.layout();
			
			text.y = text.y + 2;
		}
		
		/**
		 * @param event
		 */		
		override protected function onMouseOver( event:MouseEvent ):void
		{
            filters = _allFilters;
		}
		
		/**
		 * @param event
		 */		
		override protected function onMouseOut( event:MouseEvent ):void
		{
            filters = [];
		}
		
		// ====================================
		// PRIVATE METHODS
		// ====================================
		
		/**
		 * @return 
		 */		
		private function getGlowFilter():BitmapFilter
		{
            var color:Number = StyleDict.PURPLE1;
            var alpha:Number = 1;
            var blurX:Number = 8;
            var blurY:Number = 8;
            var strength:Number = 1.33;
            var inner:Boolean = false;
            var knockout:Boolean = false;
            var quality:Number = BitmapFilterQuality.HIGH;

            return new GlowFilter( color, alpha, blurX, blurY, strength,
                                   quality, inner, knockout );
        }
		
	}
}