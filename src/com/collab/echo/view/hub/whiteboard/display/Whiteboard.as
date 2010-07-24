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
	import com.collab.echo.view.hub.interfaces.IRoom;
	
	import flash.display.MovieClip;
	
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
		
		protected var participants			: Vector.<UserVO>;
		protected var canvas				: Canvas;
		
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
			menuItems = [ "aaa", "bbb", "ccc" ];
			
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
			var newCursor:MovieClip = timeLine.attachMovie("cursor", "cursor"+clientID, timeLine.getNextHighestDepth());
			
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
			removeMovieClip(client.getTargetMC().chat.menu_accordion.panel_mc.chatPanel_mc.content.whiteboard_accordion.whiteboard_mc["cursor"+clientID]);
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
			
			// canvas
			canvas = new Canvas( viewWidth, viewHeight - bar.height );
			addChild( canvas );
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
		}
		
		/**
		 * @private 
		 */		
		override protected function invalidate():void
		{
			removeChildFromDisplayList( canvas );
			
			super.invalidate();
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * Changes a user's color.
		 */
		internal function paintBar (clientID:String, newName:String):void
		{
			//var newKleur = new Color(client.getTargetMC().chat.video_accordion.video_mcs.content["clientVideo"+clientID].screen.colorBar);
			//newKleur.setRGB(newName);
		}
		
		/**
		 * Mouse event handler.
		 * Checks for mouseDown. 
		 */
		internal function onMouseDown ():void
		{
			//var whiteBoard_hit	: MovieClip 	= getTargetMC().chat.menu_accordion.panel_mc.chatPanel_mc.content.whiteBoard_accordion.whiteboard_mc.hit_mc;
			/*
			if (whiteBoard_hit.hitTest(_root._xmouse, _root._ymouse,true))
			{
				// start sending lines
				drawLine();
			}
			*/
		}
		
		/**
		 * Draw line and broadcast to user.
		 */
		internal function drawLine (): void
		{
			/*
			var hier 						= this;
			var whiteBoard		: MovieClip = getTargetMC().chat.menu_accordion.panel_mc.chatPanel_mc.content.whiteBoard_accordion.whiteboard_mc;
			var line_color		: Number 	= whiteBoard.ink_color.selectedColor;  
			var line_thickness	: Number 	= whiteBoard.thickness_txt.text;
			
			// anti hacking measures  
			if (line_thickness <= 5) {
				getTargetMC().totalLines++;
				
				_root.lineStukjes = new String();
				
				var myLine = whiteBoard.createEmptyMovieClip("myLine"+getTargetMC().totalLines, whiteBoard.getNextHighestDepth());
				
				// myLine._alpha = 400;
				myLine.lineStyle(line_thickness, line_color, 100);
				myLine.moveTo(whiteBoard._xmouse, whiteBoard._ymouse);
				
				// LOCAL LINE
				_root.onMouseMove = function () { 
					// if line isnt too long
					if (_root.lineStukjes.length <= 7000) {
						//trace("drawing line");  
						if (_root.chat.menu_accordion.panel_mc.chatPanel_mc.content.whiteBoard_accordion.whiteboard_mc.hit_mc.hitTest(_root._xmouse, _root._ymouse,true)) {
							// draw line on this client.
							myLine.lineTo(whiteBoard._xmouse, whiteBoard._ymouse);
							// add line-cords to string for other clients
							_root.lineStukjes += String("%"+ whiteBoard._xmouse + "," + whiteBoard._ymouse);
						}
					}
				};
				
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
				};
			}
			*/
		}
		
		/**
		 Display line for client.
		 */
		internal function displayLine (clientID:String, msg:String): void 
		{
			/*
			var userCursor:MovieClip = getTargetMC().chat.menu_accordion.panel_mc.chatPanel_mc.content.whiteBoard_accordion.whiteboard_mc["cursor"+clientID];
			userCursor.username = getTargetMC().chat.video_mcs.content["clientVideo"+clientID].screen.username
			
			var info:Array = msg.split("?");
			var line_nr:Number = info[0];
			var line_color:String = info[1];
			var line_thickness:Number = info[2];
			var cords:Array = info[3].split("%");
			// remove empty arrayelements
			cords.shift();
			
			var userBoard:MovieClip = getTargetMC().chat.menu_accordion.panel_mc.chatPanel_mc.content.whiteBoard_accordion.whiteboard_mc;
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
		 */
		internal function pullLine (x_cord:Number, y_cord:Number, line:MovieClip, userCursor:MovieClip, welke:Number, total:Number):void
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
		 */
		internal function killLine (clip:MovieClip, userCursor:MovieClip):void
		{
			//trace("i am killed "+ clip._name);
			/*
			clearInterval(clip.killMe);
			
			clip.onEnterFrame = function () {
				if (this._alpha > 0) {
					this._alpha -= 2;
					//trace("to go "  + this._alpha);
				} else {
					//trace("bye bye "  + this._name);
					removeMovieClip(this);   
				}
			}*/
		}
		
	}
}