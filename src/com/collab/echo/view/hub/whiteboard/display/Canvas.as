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
		 * Line fade-out time in seconds. 
		 */		
		public static const FADE_TIME		: int = 70;
		
		private static const LINE_NAME		: String = "myLine";
		private static const CORDS_SEP		: String = "%";
		private static const VARS_SEP		: String = "?";
		private static const PAIR_SEP		: String = ",";
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _background				: Sprite;
		private var _lines					: Sprite;
		private var _paintersLayer			: Sprite;
		private var _totalLines				: Number;
		private var _lineParts				: String;
		private var _painters				: Vector.<Painter>;
		
		/**
		 * Constructor.
		 *  
		 * @param width
		 * @param height
		 */		
		public function Canvas( width:int=0, height:int=0 )
		{
			// init vars
			_totalLines = 0;
			_painters = new Vector.<Painter>();
			
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
		 * Draw local line and broadcast to other users.
		 * 
		 * @param thickness
		 * @param color
		 */
		public function createLine( thickness:int=1,
								    color:uint=StyleDict.BLACK ): void
		{
			_totalLines++;
			_lineParts = "";
			
			// create local line
			var line:Shape = new Shape();
			line.name = LINE_NAME + _totalLines;
			line.graphics.lineStyle( thickness, color, 1 );
			line.graphics.moveTo( mouseX, mouseY );
			_lines.addChild( line );
			
			// register initial point
			registerLinePoint( mouseX, mouseY );
			
			// listen for events
			addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, false, 0,
							  true );
			addEventListener( MouseEvent.MOUSE_UP, onMouseUp, false, 0,
							  true );
		}
		
		/**
		 * Draw a shape from a remote client.
		 *  
		 * @param message
		 */		
		public function addLine( message:Object ): void 
		{
			var info:Array = message.shape.split( VARS_SEP );
			var line_nr:Number = Number( info[ 0 ]);
			var cords:Array = String( info[ 1 ] ).substr( 1 ).split( CORDS_SEP );
			var line_thickness:Number = Number( info[ 2 ]);
			var line_color:uint = uint( info[ 3 ]);
			var startPoint:Array = cords[ 0 ].split( PAIR_SEP );
			var line:Shape = new Shape();
			var user:Painter = findPainter( message.from );
			var xPos:Number = startPoint[ 0 ];
			var yPos:Number = startPoint[ 1 ];
			var frame:Number = 0;
			var cord:String;
			var pair:Array;
			
			// show user
			user.x = xPos;
			user.y = yPos;
			user.show();
			
			// initial drawing point
			line.graphics.lineStyle( line_thickness, line_color, 1 );
			line.graphics.moveTo( xPos, yPos );
			_lines.addChild( line );
			
			// XXX: create separate layers for participants and lines
			
			// draw additional points
			for each ( cord in cords )
			{
				pair = cord.split( PAIR_SEP );
				xPos = pair[ 0 ];
				yPos = pair[ 1 ];
				
				// redraw
				TweenLite.delayedCall( frame + 1, pullLine,
									   [ xPos, yPos, line, user, frame, cords.length - 1 ],
									   true );
				frame++;
			}
		}
		
		/**
		 * Add painter.
		 * 
		 * @param painter
		 */		
		public function addPainter( painter:Painter ):void
		{
			_painters.push( painter );
			_paintersLayer.addChild( painter );
		}
		
		/**
		 * Remove painter.
		 * 
		 * @param painter
		 */		
		public function removePainter( painter:Painter ):void
		{
			trace( 'Canvas.removePainter: ' + painter);
			
			var user:Painter;
			var x:int = 0;
			
			for each ( user in _painters )
			{
				if ( user == painter )
				{
					if ( _paintersLayer.contains( user ))
					{
						_paintersLayer.removeChild( user );
					}
					_painters.splice( x, 1 );
					break;
				}
				x++;
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
			
			// lines
			_lines = new Sprite();
			_lines.mouseChildren = false;
			_lines.mouseEnabled = false;
			addChild( _lines );
			
			// painters
			_paintersLayer = new Sprite();
			addChild( _paintersLayer );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			// background
			_background.x = 0;
			_background.y = 0;
			
			// lines
			_lines.x = _background.x;
			_lines.y = _background.y;
			
			// painters
			_paintersLayer.x = _background.x;
			_paintersLayer.y = _background.y;
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( _background );
			removeChildFromDisplayList( _lines );
			removeChildFromDisplayList( _paintersLayer );
			
			super.invalidate();
		}
		
		/**
		 * Fade a line.
		 *  
		 * @param line
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
		 */		
		protected function killedLine( line:DisplayObject ):void
		{
			if ( line )
			{
				_lines.removeChild( line );
			}
		}
		
		/**
		 * Pull a line.
		 *  
		 * @param x
		 * @param y
		 * @param line
		 * @param painter
		 * @param index
		 * @param total
		 */		
		protected function pullLine( x:Number, y:Number, line:Shape,
								     painter:Painter, index:Number,
									 total:Number ):void
		{
			// draw line-part
			line.graphics.lineTo( x, y );
			
			// move the painter
			painter.x = x;
			painter.y = y;
			
			// if this is the last line-part
			if ( index >= total )
			{
				// fade out painter
				painter.hide();
				
				// fade line
				TweenLite.delayedCall( FADE_TIME, fadeLine, [ line ]);
			}
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * Start drawing a local line.
		 * 
		 * @param event
		 * @private
		 */		
		protected function onMouseDown( event:MouseEvent ):void
		{
			event.stopImmediatePropagation();
			
			// notify others
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
			// register point
			registerLinePoint( event.localX, event.localY );
			
			event.stopImmediatePropagation();
			event.updateAfterEvent();
		}
		
		/**
		 * Stop drawing a local line.
		 * 
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
			
			// notify others
			var evt:WhiteboardEvent = new WhiteboardEvent( WhiteboardEvent.SEND_LINE );
			evt.line = _totalLines + VARS_SEP + _lineParts;
			dispatchEvent( evt );
			
			// fade the line after x seconds
			var line:DisplayObject = _lines.getChildByName( LINE_NAME + _totalLines );
			TweenLite.delayedCall( FADE_TIME, fadeLine, [ line ]);
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * @param client
		 * @return 
		 */		
		internal function findPainter( client:* ):Painter
		{
			// XXX: probably move into the Whiteboard or higher
			var user:Painter;
			
			for each ( user in _painters )
			{
				if ( user.data.client == client )
				{
					break;
				}
			}
			
			return user;
		}
		
		/**
		 * @param mouseX
		 * @param mouseY
		 */		
		internal function registerLinePoint( mouseX:int, mouseY:int ):void
		{
			// if line isn't too long
			if ( _lineParts.length <= 7000 )
			{
				var line:Shape = _lines.getChildByName( LINE_NAME + _totalLines ) as Shape;
				line.graphics.lineTo( mouseX, mouseY );
				
				// add line-cords to string for other clients
				_lineParts += String( CORDS_SEP + mouseX + PAIR_SEP + mouseY );
			}
		}

	}
}