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
package com.collab.echo.core
{
	import com.collab.echo.events.EchoEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * Dispatched when the creation of the component has completed.
	 *
	 * @eventType com.collab.echo.events.EchoEvent.CREATION_COMPLETE
	 */
	[Event(name="creationComplete", type="com.collab.echo.events.EchoEvent")]
	
	/**
	 * Dispatched when the component is closed.
	 *
	 * @eventType com.collab.echo.events.EchoEvent.CLOSE_VIEW
	 */
	[Event(name="closeView", type="com.collab.echo.events.EchoEvent")]
	
	/**
	 * The UIComponent class is the base class for all visual components, both
	 * interactive and noninteractive.
	 *  
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class UIComponent extends Sprite
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * Width of this view component, in pixels. 
		 */		
		protected var viewWidth					: Number;
		
		/**
		 * Height of this view component, in pixels. 
		 */		
		protected var viewHeight				: Number;
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		/**
		 * @private 
		 */		
		internal var isLoading					: Boolean;
		
		// ====================================
		// ACCESSOR/MUTATOR
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get loading():Boolean
		{
			return isLoading;
		}
		public function set loading( val:Boolean ):void
		{
			isLoading = val;
		}
		
		/**
		 * Constructor.
		 * 
		 * @param width 	Width of this UI component
		 * @param height 	Height of this UI component
		 */		
		public function UIComponent( width:Number=0, height:Number=0 )
		{
			super();
			
			viewWidth = width;
			viewHeight = height;
			tabEnabled = false;
			isLoading = false;
			
			hide();
			
			// listen for events
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage,
							  false, 0, true );
		}

		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Invoked when <code>viewComponent</code> was added to the display list.
		 * 
		 * @param event
		 */		
		protected function onAddedToStage( event:Event ):void
		{
			// cleanup listeners
			removeEventListener( event.type, onAddedToStage );
			
			// UI
			invalidate();
			
			dispatchEvent( new EchoEvent( EchoEvent.CREATION_COMPLETE ));
		}
		
		/**
		 * Show view. 
		 */		
		public function show():void
		{
			visible = true;
		}

		/**
		 * Hide view.
		 */				
		public function hide():void
		{
			visible = false;
		}
		
		/**
		 * Disable interaction. 
		 */		
		public function disable():void
		{
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		/**
		 * Enable interaction. 
		 */		
		public function enable():void
		{
			mouseChildren = true;
			mouseEnabled = true;
		}
		
		/**
		 * Moves the component to the specified position.
		 * 
		 * @param xpos 	The x position to move the component
		 * @param ypos 	The y position to move the component
		 */
		public function move( xpos:Number, ypos:Number ):void
		{
			x = Math.round( xpos );
			y = Math.round( ypos );
		}
		
		/**
		 * Sets the size of the component.
		 * 
		 * @param width		The width of the component.
		 * @param height 	The height of the component.
		 */		
		public function setSize( width:int, height:int ):void
		{
			viewWidth = width;
			viewHeight = height;
			
			invalidate();
		}
		
		/**
		 * Instantiate and add child(ren) to display list.
		 */		
		protected function draw():void
		{
		}
		
		/**
		 * Position child(ren) on display list.
		 */		
		protected function layout():void
		{
		}
		
		/**
		 * Remove and redraw child(ren).
		 */		
		protected function invalidate():void
		{
			draw();
			layout();
		}
		
		/**
		 * Vertically align a component in the view.
		 * 
		 * @param component
		 */		
		protected function verticalAlign( component:* ):void
		{
			component.y = viewHeight / 2 - component.height / 2;
		}
		
		/**
		 * Remove child from display list.
		 * 
		 * @param child 
		 */		
		protected function removeChildFromDisplayList( child:DisplayObject ):void
		{
			if ( child && contains( child ))
			{
				try
				{
					removeChild( child );
				}
				catch ( e:ArgumentError )
				{
				}
				
				child = null;
			}
		}
		
	}
}