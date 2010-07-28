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
	import com.collab.echo.view.hub.interfaces.IRoom;
	import com.collab.echo.view.hub.whiteboard.events.WhiteboardEvent;
	
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
		protected var participants			: Vector.<Painter>;
		
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
		
		private var _lineColor				: uint;
		private var _lineThickness			: Number;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get lineColor()		: uint
		{
			return _lineColor;
		}
		
		/**
		 * @return 
		 */		
		public function get lineThickness()	: Number
		{
			return _lineThickness;
		}
		
		/**
		 * Constructor.
		 * 
		 * @param width
		 * @param height
		 */		
		public function Whiteboard( width:int=0, height:int=0 )
		{
			// init vars
			participants = new Vector.<Painter>();
			_lineThickness = 1;
			_lineColor = StyleDict.BLACK;
			
			// XXX: move elsewhere
			menuItems = [ "Settings" ];
			
			super( width, height );
			show();
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @param client
		 */		
		public function joinedRoom( client:UserVO ):void
		{
			//Logger.debug( "Whiteboard.joinedRoom: " + client );
		}
		
		/**
		 * Client joined the room.
		 * 
		 * @param client
		 */		
		public function addUser( client:UserVO ):void
		{
			var user:Painter;
			
			// add painter
			if ( client.client.isSelf() )
			{
				user = new LocalPainter( client );
			}
			else
			{
				user = new RemotePainter( client );
			}
			 
			participants.push( user );
			canvas.addPainter( user );
		}
		
		/**
		 * @param client
		 */		
		public function removeUser( client:UserVO ):void
		{
			var user:Painter;
			var x:int = 0;
			
			for each ( user in participants )
			{
				if ( user.data == client )
				{
					// remove painter
					canvas.removePainter( user );
					participants.splice( x, 1 );
					break;
				}
				x++;
			}
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
		
		/**
		 * Add line from remote client.
		 * 
		 * @param message
		 */		
		public function addLine( message:Object ):void
		{
			message.painter = findPainter( message.from );
			
			canvas.addLine( message );
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
			canvas.addEventListener( WhiteboardEvent.SEND_LINE, onSendLine,
								     false, 0, true );
			addChild( canvas );
			addChild( toolbar );
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
			
			// TODO
		}
		
		/**
		 * Changes a user's color.
		 * 
		 * @param event
		 */		
		protected function onChangeColor( event:WhiteboardEvent ):void
		{
			event.stopImmediatePropagation();
			
			_lineColor = event.color;
		}
		
		/**
		 * Changes a user's line thickness.
		 * 
		 * @param event
		 */		
		protected function onChangeThickness( event:WhiteboardEvent ):void
		{
			event.stopImmediatePropagation();
			
			_lineThickness = event.thickness;
		}
		
		/**
		 * Start drawing a local line.
		 * 
		 * @param event
		 */		
		protected function onDrawLine( event:WhiteboardEvent ):void
		{
			event.stopImmediatePropagation();
			
			canvas.createLine( _lineThickness, _lineColor );
		}
		
		/**
		 * Send a local line to the server.
		 * 
		 * @param event
		 */		
		protected function onSendLine( event:WhiteboardEvent ):void
		{
			event.stopImmediatePropagation();
			
			//trace( "Whiteboard.onSendLine: " + event );
			
			var evt:WhiteboardEvent = new WhiteboardEvent( WhiteboardEvent.SEND_LINE );
			evt.line = event.line + "?" + _lineThickness + "?" + _lineColor;
			dispatchEvent( evt );
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param client
		 * @return 
		 */		
		internal function findPainter( client:* ):Painter
		{
			var user:Painter;
			
			for each ( user in participants )
			{
				if ( user.data.client == client )
				{
					break;
				}
			}
			
			return user;
		}
		
	}
}