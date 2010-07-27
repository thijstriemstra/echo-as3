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
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.display.util.TextUtils;
	
	import fl.controls.Slider;
	import fl.controls.SliderDirection;
	
	import flash.text.TextField;
	
	/**
	 * @author Thijs Triemstra
	 */	
	public class ThicknessSlider extends BaseView
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		internal static const THICKNESS_MAX		: int = 10;
		internal static const THICKNESS_MIN		: int = 1;
		internal static const THICKNESS_DEFAULT	: int = THICKNESS_MIN;
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * <p>TODO: find alternative for fl.controls.Slider</p>
		 */		
		protected var slider		: Slider;
		
		/**
		 * Label field. 
		 */		
		protected var label			: TextField;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _label			: String;
		private var _minimum		: int;
		private var _maximum		: int;
		private var _value			: int;
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 * @param label
		 * @param minimum
		 * @param maximum
		 * @param value
		 */		
		public function ThicknessSlider( width:Number=0, height:Number=0,
										 label:String=null,
										 minimum:int=THICKNESS_MIN,
										 maximum:int=THICKNESS_MAX,
										 value:int=THICKNESS_MIN )
		{
			_label = label;
			_minimum = minimum;
			_maximum = maximum;
			_value = value;
			
			super( width, height );
			show();
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override protected function draw():void
		{
			// label
			label = TextUtils.createTextField( null, _label );
			addChild( label );
			
			// slider
			slider = new Slider();
			slider.direction = SliderDirection.HORIZONTAL;
			slider.minimum = _minimum;
			slider.maximum = _maximum;
			slider.value = _value;
			slider.tickInterval = 1;
			slider.snapInterval = 1;
			slider.liveDragging = true;
			slider.setSize( viewWidth, viewHeight );
			addChild( slider );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// label
			label.x = 0
			label.y = 5;
			
			// slider
			slider.x = label.x + label.width + 10;
			slider.y = 5;
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( label );
			removeChildFromDisplayList( slider );
			
			super.invalidate();
		}
		
	}
}