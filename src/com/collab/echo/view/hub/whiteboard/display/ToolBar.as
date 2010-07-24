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
	import com.collab.echo.view.controls.buttons.LabelButton;
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.display.util.DrawingUtils;
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.hub.whiteboard.events.WhiteboardEvent;
	
	import fl.controls.ColorPicker;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * Toolbar containing a color picker.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class ToolBar extends BaseView
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		protected var background 		: Sprite;
		
		// XXX: find alternative for fl.controls
		/**
		 * 
		 */		
		protected var colorPicker		: ColorPicker;
		
		/**
		 * 
		 */		
		protected var undoButton		: LabelButton;
		
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
												 0, StyleDict.GREY1 );
			addChild( background );
			
			// color picker
			colorPicker = new ColorPicker();
			addChild( colorPicker );
			
			// undo button
			undoButton = new LabelButton( 50, 15, StyleDict.BLACK, 0, 0 );
			undoButton.addEventListener( MouseEvent.CLICK, undoAction, false, 0, true );
			undoButton.label = "Undo";
			addChild( undoButton );
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
			colorPicker.x = 10;
			colorPicker.y = 8;
			
			// undo button
			undoButton.x = colorPicker.x + colorPicker.width + 5;
			undoButton.y = 10;
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( background );
			removeChildFromDisplayList( colorPicker );
			
			super.invalidate();
		}
		
		/**
		 * @param event
		 */		
		private function undoAction( event:MouseEvent ):void
		{
			trace( "undo: " + event );
			
			var evt:WhiteboardEvent = new WhiteboardEvent( WhiteboardEvent.UNDO );
			dispatchEvent( evt );
		}
		
	}
}