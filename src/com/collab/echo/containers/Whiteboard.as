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
package com.collab.echo.containers
{
	import com.collab.cabin.display.util.StyleDict;
	import com.collab.echo.containers.panels.MenuPanel;
	import com.collab.echo.controls.ToolBar;
	import com.collab.echo.controls.WhiteboardCanvas;
	import com.collab.echo.controls.painter.LocalPainter;
	import com.collab.echo.controls.painter.Painter;
	import com.collab.echo.controls.painter.RemotePainter;
	import com.collab.echo.core.rooms.IRoom;
	import com.collab.echo.core.rooms.IWhiteboardRoom;
	import com.collab.echo.events.WhiteboardEvent;
	import com.collab.echo.model.UserVO;
	
	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * @eventType com.collab.echo.events.WhiteboardEvent.SEND_LINE
	 */
	[Event(name="sendLine", type="com.collab.echo.events.WhiteboardEvent")]
	
	/**
	 * Shared whiteboard.
	 * 
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 10
	 */	
	public class Whiteboard extends MenuPanel implements IWhiteboardRoom, IRoom
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * The users currently using the whiteboard.
		 */		
		protected var participants			: Vector.<Painter>;
		
		/**
		 * The canvas to draw on.
		 */		
		protected var canvas				: WhiteboardCanvas;
		
		/**
		 * Toolbar containing color picker, etc.
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
		 * Line color for local client.
		 * 
		 * @return 
		 */		
		public function get lineColor()		: uint
		{
			return _lineColor;
		}
		
		/**
		 * Line thickness for local client.
		 * 
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
		 * Local client joined the room.
		 * 
		 * @param client
		 */		
		public function joinedRoom( client:UserVO ):void
		{
			//Logger.debug( "Whiteboard.joinedRoom: " + client );
		}
		
		/**
		 * @param client
		 * @param attr
		 */		
		public function clientAttributeUpdate( client:UserVO, attr:Object ):void
		{
		}
		
		/**
		 * Client joined the room.
		 * 
		 * @param client
		 */		
		public function addOccupant( client:UserVO ):void
		{
			var user:Painter;
			
			// add painter
			if ( client && client.client.isSelf() )
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
		 * Client left the room.
		 * 
		 * @param client
		 */		
		public function removeOccupant( client:UserVO ):void
		{
			var user:Painter;
			var x:int = 0;
			
			for each ( user in participants )
			{
				if ( client && user.data == client )
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
		 * The number of total clients in the room updated.
		 * 
		 * @param total
		 */		
		public function numClients( total:int ):void
		{
			//Logger.debug( "Whiteboard.numClients: " + total );
		}
		
		/**
		 * Add a line from remote client.
		 * 
		 * @param message
		 */		
		public function addLine( message:Object ):void
		{
			message.painter = findPainterByClient( message.from );
			
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
			// XXX: localize
			toolbar.colorLabel = "COLOR";
			toolbar.thicknessLabel =  "THICKNESS";
			toolbar.addEventListener( WhiteboardEvent.UNDO, onUndo, false, 0, true );
			toolbar.addEventListener( WhiteboardEvent.CHANGE_COLOR, onChangeColor,
									  false, 0, true );
			toolbar.addEventListener( WhiteboardEvent.CHANGE_THICKNESS, onChangeThickness,
									  false, 0, true );

			// canvas
			canvas = new WhiteboardCanvas( viewWidth, viewHeight - ( bar.height + toolbar.height ));
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
		 * User wants to undo an action.
		 * 
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
		 * Find a user by it's client property.
		 * 
		 * @param client
		 * @return
		 * @private 
		 */		
		internal function findPainterByClient( client:* ):Painter
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