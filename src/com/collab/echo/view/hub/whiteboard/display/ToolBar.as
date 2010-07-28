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
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.display.util.DrawingUtils;
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.hub.whiteboard.events.WhiteboardEvent;
	import com.collab.echo.view.hub.whiteboard.tools.FlashColorPicker;
	import com.collab.echo.view.hub.whiteboard.tools.ThicknessSlider;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * @eventType com.collab.echo.view.hub.whiteboard.events.WhiteboardEvent.UNDO
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0.28.0
	 *  
	 * @playerversion AIR 1.0
	 */
	[Event(name="WhiteboardEvent_undo", type="com.collab.echo.view.hub.whiteboard.events.WhiteboardEvent")]
	
	/**
	 * Toolbar containing a color picker.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class ToolBar extends BaseView
	{
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
			// XXX: localize
			colorPicker = new FlashColorPicker( "COLOR" );
			addChild( colorPicker );
			
			// thickness
			// XXX: localize
			thickness = new ThicknessSlider( 150, 50, "THICKNESS" );
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