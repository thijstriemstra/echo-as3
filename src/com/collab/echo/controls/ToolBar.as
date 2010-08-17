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
	import com.collab.echo.controls.tools.ThicknessSlider;
	import com.collab.echo.display.util.DrawingUtils;
	import com.collab.echo.display.util.StyleDict;
	import com.collab.echo.events.WhiteboardEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * @eventType com.collab.echo.events.WhiteboardEvent.UNDO
	 */
	[Event(name="undo", type="com.collab.echo.events.WhiteboardEvent")]
	
	/**
	 * Toolbar containing a color picker.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class ToolBar extends UIComponent
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _colorLabel					: String;
		private var _thicknessLabel				: String;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get colorLabel():String
		{
			return _colorLabel;
		}
		public function set colorLabel( val:String ):void
		{
			if ( val )
			{
				_colorLabel = val;
			}
		}
		
		/**
		 * @return 
		 */		
		public function get thicknessLabel():String
		{
			return _thicknessLabel;
		}
		public function set thicknessLabel( val:String ):void
		{
			if ( val )
			{
				_thicknessLabel = val;
			}
		}
		
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * Toolbar background. 
		 */		
		protected var background 				: Sprite;
		
		/**
		 * Tool for selecting a line color.
		 */		
		protected var colorPicker				: FlashColorPicker;
		
		/**
		 * Tool for selecting line thickness.
		 */		
		protected var thickness					: ThicknessSlider;
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 */		
		public function ToolBar( width:Number=0, height:Number=40 )
		{
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
			// background
			background = DrawingUtils.drawFill( viewWidth, viewHeight,
												 0, StyleDict.GREY1, .5 );
			addChild( background );
			
			// color picker
			colorPicker = new FlashColorPicker( _colorLabel );
			addChild( colorPicker );
			
			// thickness
			// XXX: localize
			thickness = new ThicknessSlider( 150, 50, _thicknessLabel );
			addChild( thickness );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// background
			background.x = 0;
			background.y = 0;
			
			// color picker
			colorPicker.x = 5;
			colorPicker.y = 8;
			
			// thickness
			thickness.x = colorPicker.x + colorPicker.width + 40;
			thickness.y = 8;
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( background );
			removeChildFromDisplayList( colorPicker );
			removeChildFromDisplayList( thickness );
			
			super.invalidate();
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 */		
		private function undoAction( event:MouseEvent ):void
		{
			event.stopImmediatePropagation();
			
			var evt:WhiteboardEvent = new WhiteboardEvent( WhiteboardEvent.UNDO );
			dispatchEvent( evt );
		}
		
	}
}