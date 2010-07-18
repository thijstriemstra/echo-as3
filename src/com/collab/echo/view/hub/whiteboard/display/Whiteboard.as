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
	import com.collab.echo.view.controls.buttons.LabelButton;
	import com.collab.echo.view.display.BaseView;
	import com.collab.echo.view.hub.interfaces.IPresence;
	
	/**
	 * A shared whiteboard.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class Whiteboard extends BaseView implements IPresence
	{
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		internal var participants		: Array;
		//internal var colorPicker		: Colorpicker;
		internal var canvas				: Canvas;
		internal var undoButton			: LabelButton;
		
		/**
		 * Constructor.
		 * 
		 * @param width
		 * @param height
		 */		
		public function Whiteboard( width:int=0, height:int=0 )
		{
			super( width, height );
			show();
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * @param client
		 */		
		public function addUser( client:UserVO ):void
		{
			//Logger.debug( "Whiteboard.addUser: " + client );
			
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
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		override protected function draw():void
		{
			// canvas
			canvas = new Canvas();
			addChild( canvas );
			
			// participants
			participants = [];
			
			var user1:Painter = new Painter();
			participants.push( user1 );
		}
		
	}
}