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
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * Whiteboard canvas.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class Canvas extends BaseView
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		/**
		 * In seconds. 
		 */		
		public static const FADE_TIME		: int = 70;
		
		/**
		 * 
		 */		
		private static const LINE_NAME		: String = "myLine";
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _background				: Sprite;
		private var _totalLines				: Number;
		private var _lineStukjes			: String;
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 */		
		public function Canvas( width:int=0, height:int=0 )
		{
			_totalLines = 0;
			
			super( width, height );
			show();
			
			// listen for events
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown, false, 0,
							  true );
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Draw local line and broadcast to user.
		 * 
		 * @param thickness
		 * @param color
		 */
		public function createLine( thickness:int=1,
								    color:uint=StyleDict.BLACK ): void
		{
			_totalLines++;
			_lineStukjes = "";
			
			// create local line
			var line:Shape = new Shape();
			line.name = LINE_NAME + _totalLines;
			line.graphics.lineStyle( thickness, color, 1 );
			line.graphics.moveTo( mouseX, mouseY );
			addChild( line );
			
			// listen for events
			addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, false, 0,
							  true );
			addEventListener( MouseEvent.MOUSE_UP, onMouseUp, false, 0,
							  true );
			addEventListener( MouseEvent.MOUSE_OUT, onMouseUp, false, 0,
							  true );
		}
		
		/**
		 * Display line from remote client.
		 *  
		 * @param message
		 */		
		public function addLine( message:String ): void 
		{
			/*
			var userCursor:Sprite = whiteboard_mc["cursor"+clientID];
			userCursor.username = content["clientVideo"+clientID].screen.username
			*/
			
			var info:Array = message.split( "?" );
			var line_nr:Number = info[ 0 ];
			var cords:Array = info[ 1 ].split( "%" );
			var line_thickness:Number = info[ 2 ];
			var line_color:uint = info[ 3 ];
			
			// remove empty array elements
			cords.shift();
			
			var line:Shape = new Shape();
			var startPoint:Array = cords[ 0 ].split( "," );
			
			// XXX: fix width and color
			line.graphics.lineStyle( 1, StyleDict.BLACK, 1 );
			line.graphics.moveTo( startPoint[ 0 ], startPoint[ 1 ]);
			addChild( line );
			
			//userCursor.swapDepths( line );
			
			var waardes:Array
			var r:int;
			var x:Number;
			var y:Number;
			
			for ( r = 1; r < cords.length; r++ )
			{
				waardes = cords[ r ].split( "," );
				x = waardes[ 0 ];
				y = waardes[ 1 ];
				
				TweenLite.delayedCall( r / 20, pullLine,
									   [ x, y, line, r, cords.length - 1 ]);
			}
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
			_background = DrawingUtils.drawFill( viewWidth, viewHeight, 0,
												 StyleDict.WHITE, 1 );
			addChild( _background );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// background
			_background.x = 0;
			_background.y = 0;
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _background );
			
			super.invalidate();
		}
		
		/**
		 * Fade a line.
		 *  
		 * @param line
		 * @private
		 */		
		protected function fadeLine( line:DisplayObject ):void
		{
			if ( line )
			{
				TweenLite.to( line, 2, { alpha: 0, onComplete: killedLine,
									 	 onCompleteParams: [ line ]});
			}
		}
		
		/**
		 * Delete a line.
		 * 
		 * @param line
		 * @private
		 */		
		protected function killedLine( line:DisplayObject ):void
		{
			if ( line )
			{
				removeChild( line );
			}
		}
		
		/**
		 * Pull a line.
		 *  
		 * @param x
		 * @param y
		 * @param line
		 * @param welke
		 * @param total
		 */		
		protected function pullLine( x:Number, y:Number, line:Shape,
								     welke:Number, total:Number ):void
		{
			// draw line-part
			line.graphics.lineTo( x, y );
			trace('pullLine: ' + line + ", x: " + x, ", y: " + y );
			
			// show and move the cursor
			/*
			userCursor.visible = true;
			userCursor.x = x;
			userCursor.y = y;
			*/
			
			// if this is the last line-part
			if (welke >= total)
			{
				// fade out cursor
				//userCursor.gotoAndPlay("close");
				
				TweenLite.delayedCall( FADE_TIME, fadeLine, [ line ]);
			}
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 * @private
		 */		
		protected function onMouseDown( event:MouseEvent ):void
		{
			event.stopImmediatePropagation();
			
			var evt:WhiteboardEvent = new WhiteboardEvent( WhiteboardEvent.DRAW_LINE );
			dispatchEvent( evt );
		}
		
		/**
		 * Draw line on this client.
		 * 
		 * @param event
		 * @private
		 */		
		protected function onMouseMove( event:MouseEvent ):void
		{
			event.stopImmediatePropagation();
			
			// if line isn't too long
			if ( _lineStukjes.length <= 7000 )
			{
				var line:Shape = getChildByName( LINE_NAME + _totalLines ) as Shape;
				line.graphics.lineTo( event.localX, event.localY );
			
				// add line-cords to string for other clients
				_lineStukjes += String( "%" + event.localX + "," + event.localY );
			}
		}
		
		/**
		 * @param event
		 * @private
		 */		
		protected function onMouseUp( event:MouseEvent ):void
		{
			event.stopImmediatePropagation();
			
			// remove event handlers
			removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			removeEventListener( MouseEvent.MOUSE_OUT, onMouseUp );
			
			var evt:WhiteboardEvent = new WhiteboardEvent( WhiteboardEvent.SEND_LINE );
			evt.line = _totalLines + "?" + _lineStukjes;
			dispatchEvent( evt );
			
			// fade the line after x seconds
			var line:DisplayObject = getChildByName( LINE_NAME + _totalLines );
			TweenLite.delayedCall( FADE_TIME, fadeLine, [ line ]);
		}

	}
}