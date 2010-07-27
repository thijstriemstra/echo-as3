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
	import com.collab.echo.model.vo.UserVO;
	import com.collab.echo.view.containers.panels.MenuPanel;
	import com.collab.echo.view.display.util.StyleDict;
	import com.collab.echo.view.display.util.TextUtils;
	import com.collab.echo.view.hub.interfaces.IRoom;
	import com.collab.echo.view.hub.whiteboard.events.WhiteboardEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * A shared whiteboard.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class Whiteboard extends MenuPanel implements IRoom
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * 
		 */		
		protected var participants			: Vector.<UserVO>;
		
		/**
		 * 
		 */		
		protected var canvas				: Canvas;
		
		/**
		 * 
		 */		
		protected var toolbar				: ToolBar;
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _label					: TextField;
		private var _lineColor				: uint;
		private var _lineThickness			: Number;
		private var _totalLines				: Number;
		
		/**
		 * Constructor.
		 * 
		 * @param width
		 * @param height
		 */		
		public function Whiteboard( width:int=0, height:int=0 )
		{
			// init vars
			participants = new Vector.<UserVO>();
			
			// XXX: move elsewhere
			menuItems = [ "Settings" ];
			
			super( width, height );
			show();
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Joined the room.
		 * 
		 * @param client
		 */		
		public function joinedRoom( client:UserVO ):void
		{
			//Logger.debug( "Whiteboard.joinedRoom: " + client );
		}
		
		/**
		 * @param client
		 */		
		public function addUser( client:UserVO ):void
		{
			trace( "Whiteboard.addUser: " + client );
			
			//var user:Painter = new Painter();
			//participants.push( user );
			
			/*
			var newCursor:MovieClip = timeLine.attachMovie("cursor", "cursor"+clientID, 
															timeLine.getNextHighestDepth());
			
			newCursor.username = username;
			newCursor._visible = false;
			*/
		}
		
		/**
		 * @param client
		 */		
		public function removeUser( client:UserVO ):void
		{
			//Logger.debug( "Whiteboard.removeUser: " + client );
			
			/*
			// remove user cursor
			removeMovieClip( whiteboard_mc["cursor"+clientID] );
			*/
		}
		
		/**
		 * Total clients in room updated.
		 * 
		 * @param totalClients
		 */		
		public function numClients( totalClients:int ):void
		{
			//Logger.debug( "Whiteboard.numClients: " + totalClients );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * @private 
		 */		
		override protected function draw():void
		{
			super.draw();
			
			// toolbar
			toolbar = new ToolBar( viewWidth );
			toolbar.addEventListener( WhiteboardEvent.UNDO, onUndo, false, 0, true );
			toolbar.addEventListener( WhiteboardEvent.CHANGE_COLOR, onChangeColor,
									  false, 0, true );
			toolbar.addEventListener( WhiteboardEvent.CHANGE_THICKNESS, onChangeThickness,
									  false, 0, true );

			// canvas
			canvas = new Canvas( viewWidth, viewHeight - ( bar.height + toolbar.height ));
			canvas.addEventListener( WhiteboardEvent.DRAW_LINE, onDrawLine,
									 false, 0, true );
			addChild( canvas );
			addChild( toolbar );
			
			// label
			_label = TextUtils.createTextField( null, "Whiteboard!", 15,
												StyleDict.BLACK );
			addChild( _label );
		}
		
		/**
		 * @private 
		 */		
		override protected function layout():void
		{
			super.layout();
			
			// canvas
			canvas.x = 0;
			canvas.y = bar.y + bar.height;
			
			// toolbar
			toolbar.x = 0;
			toolbar.y = canvas.y + canvas.height;
			
			// label
			_label.x = 10;
			_label.y = canvas.y + 15;
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( canvas );
			removeChildFromDisplayList( toolbar );
			
			super.invalidate();
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 */		
		protected function onUndo( event:WhiteboardEvent ):void
		{
			event.stopImmediatePropagation();
			
			trace( "Whiteboard.onUndo: " + event );
		}
		
		/**
		 * Changes a user's color.
		 * 
		 * @param event
		 */		
		protected function onChangeColor( event:WhiteboardEvent ):void
		{
			event.stopImmediatePropagation();
			
			trace( "Whiteboard.onChangeColor: " + event );
			
			//var newKleur = new Color(content["clientVideo"+clientID].screen.colorBar);
			//newKleur.setRGB(newName);
		}
		
		/**
		 * Changes a user's line thickness.
		 * 
		 * @param event
		 */		
		protected function onChangeThickness( event:WhiteboardEvent ):void
		{
			event.stopImmediatePropagation();
			
			trace( "Whiteboard.onChangeThickness: " + event );
		}
		
		/**
		 * Changes a user's line thickness.
		 * 
		 * @param event
		 */		
		protected function onDrawLine( event:WhiteboardEvent ):void
		{
			event.stopImmediatePropagation();
			
			trace( "Whiteboard.onDrawLine: " + event );
			
			drawLine( event.target as Canvas );
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * Draw local line and broadcast to user.
		 * 
		 * @param target
		 */
		internal function drawLine( target:Canvas ): void
		{
			_totalLines++;
			
			//_root.lineStukjes = new String();
			
			var myLine:Sprite = new Sprite();
			myLine.name = "myLine" + _totalLines;
			myLine.graphics.lineStyle( _lineThickness, _lineColor, 1 );
			myLine.graphics.moveTo( target.mouseX, target.mouseY );
			
			/*
			_root.onMouseMove = function () { 
				// if line isnt too long
				if (_root.lineStukjes.length <= 7000) {
					//trace("drawing line");  
					if (whiteboard_mc.hit_mc.hitTest(_root._xmouse, _root._ymouse,true)) {
						// draw line on this client.
						myLine.lineTo(whiteBoard._xmouse, whiteBoard._ymouse);
						// add line-cords to string for other clients
						_root.lineStukjes += String("%"+ whiteBoard._xmouse + "," + whiteBoard._ymouse);
					}
				}
			}
			
			_root.onMouseUp = function () {
				// remove event handlers
				delete _root.onMouseMove;
				delete _root.onMouseUp;
				//trace("Length line: " + _root.lineStukjes.length);
				
				// Send the message to the server.
				var safeMsg:String = '<![CDATA[' + _root.totalLines + "?" + line_color + "?" + line_thickness + "?" + _root.lineStukjes +']]>';
				trace(safeMsg.length);
				//trace("safeMessage "+safeMsg);
				hier.invokeOnRoom("displayLine", AppSettings.fnsid, false, safeMsg);
				
				// fade the line
				myLine.killMe = setInterval(hier.killLine, 70000, myLine);
			}
			*/
		}
		
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