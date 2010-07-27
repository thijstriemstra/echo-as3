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
	
	import flash.display.MovieClip;
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
		// PRIVATE VARS
		// ====================================
		
		private var _background				: Sprite;
		private var _localLine				: Shape;
		
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
		public function drawLine( thickness:int=1,
								  color:uint=StyleDict.BLACK ): void
		{
			_totalLines++;
			_lineStukjes = "";
			
			// create local line
			_localLine = new Shape();
			_localLine.name = "myLine" + _totalLines;
			_localLine.graphics.lineStyle( thickness, color, 1 );
			_localLine.graphics.moveTo( mouseX, mouseY );
			addChild( _localLine );
			
			// listen for events
			addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, false, 0,
							  true );
			addEventListener( MouseEvent.MOUSE_UP, onMouseUp, false, 0,
							  true );
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
			removeChildFromDisplayList( _localLine );
			
			super.invalidate();
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
				_localLine.graphics.lineTo( event.localX, event.localY );
			
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

			//trace("Length line: " + _lineStukjes.length);
			
			var evt:WhiteboardEvent = new WhiteboardEvent( WhiteboardEvent.SEND_LINE );
			dispatchEvent( evt );
			
			/*
			// fade the line
			_localLine.killMe = setInterval( killLine, 70000, _localLine );
			*/
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * Display line for client.
		 *  
		 * @param clientID
		 * @param msg
		 */		
		internal function displayLine(clientID:String, msg:String): void 
		{
			/*
			var userCursor:MovieClip = whiteboard_mc["cursor"+clientID];
			userCursor.username = content["clientVideo"+clientID].screen.username
			
			var info:Array = msg.split("?");
			var line_nr:Number = info[0];
			var line_color:String = info[1];
			var line_thickness:Number = info[2];
			var cords:Array = info[3].split("%");
			// remove empty arrayelements
			cords.shift();
			
			var userBoard:MovieClip = whiteboard_mc;
			var line = userBoard.createEmptyMovieClip("lijn"+line_nr, userBoard.getNextHighestDepth());
			var startPoint:Array = cords[0].split(",");
			
			line.lineStyle(line_thickness, line_color, 100);
			line.moveTo(startPoint[0], startPoint[1]);
			
			userCursor.swapDepths(line);
			
			for (var r=1; r<cords.length; r++) {
			var waardes = cords[r].split(",");
			var x_cord:Number = waardes[0];
			var y_cord:Number = waardes[1];
			line["pull"+r] = setInterval(pullLine, (r*10), x_cord, y_cord, line, userCursor, r, cords.length-1);
			}
			*/
		}
		
		/**
		 * Pull a line.
		 *  
		 * @param x_cord
		 * @param y_cord
		 * @param line
		 * @param userCursor
		 * @param welke
		 * @param total
		 */		
		internal function pullLine(x_cord:Number, y_cord:Number, line:MovieClip,
								   userCursor:MovieClip, welke:Number, total:Number):void
		{
			/*
			// draw line-part
			line.lineTo(x_cord, y_cord);
			
			// show and move the cursor
			userCursor._visible = true;
			userCursor._x = x_cord;
			userCursor._y = y_cord;
			var hier = this;
			
			// dont do this again
			clearInterval(line["pull"+welke]);
			
			// if this is the last line-part
			if (welke >= total) {
			//trace("END " + welke + " : " + line._name);
			// fade out cursor
			userCursor.gotoAndPlay("close");
			
			// kill the line slow and painfully
			line.killMe = setInterval(_root.sc.killLine, 70000, line, userCursor);
			}
			*/
		}
		
		/**
		 * Delete a line.
		 *  
		 * @param clip
		 * @param userCursor
		 */		
		internal function killLine( clip:MovieClip, userCursor:MovieClip ):void
		{
			/*
			trace("i am killed "+ clip._name);
			
			clearInterval(clip.killMe);
			
			clip.onEnterFrame = function () {
			if (this._alpha > 0) {
			this._alpha -= 2;
			//trace("to go "  + this._alpha);
			} else {
			//trace("bye bye "  + this._name);
			removeMovieClip(this);   
			}
			}
			*/
		}
		
	}
}