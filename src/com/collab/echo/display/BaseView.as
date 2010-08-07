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
package com.collab.echo.display
{
	import com.collab.echo.display.util.StyleDict;
	import com.collab.echo.display.util.TextUtils;
	import com.collab.echo.events.ViewEvent;
	import com.collab.echo.preloaders.CirclePreloader;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getQualifiedClassName;

	// ====================================
	// EVENTS
	// ====================================
	
	/**
	 * Dispatched when the creation of this view has completed.
	 *
	 * @eventType com.collab.echo.events.ViewEvent.CREATION_COMPLETE
	 */
	[Event(name="creationComplete", type="com.collab.echo.events.ViewEvent")]
	
	/**
	 * Dispatched when this view is closed.
	 *
	 * @eventType com.collab.echo.events.ViewEvent.CLOSE_VIEW
	 */
	[Event(name="closeView", type="com.collab.echo.events.ViewEvent")]
	
	/**
	 * Common display class with shared view functionality.
	 *  
	 * @author Thijs Triemstra
	 */	
	public class BaseView extends Sprite
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
		
		/**
		 * Title textfield, used for debugging. 
		 */		
		protected var titleField				: TextField;
		
		// ====================================
		// INTERNAL VARS
		// ====================================
		
		/**
		 * @private 
		 */		
		internal var preloader					: CirclePreloader;
		
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
			if ( preloader )
			{
				isLoading = val;
				preloader.visible = ( isLoading == true );
			}
		}
		
		/**
		 * Constructor.
		 * 
		 * @param width Width of this view component
		 * @param height Height of this view component
		 */		
		public function BaseView( width:Number=0, height:Number=0 )
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
		// PUBLIC/PROTECTED METHODS
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
			
			dispatchEvent( new ViewEvent( ViewEvent.CREATION_COMPLETE ));
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
		 * Resize view.
		 * 
		 * @param width
		 * @param height
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
			var text:String = getQualifiedClassName( this ).split( "::" )[ 1 ];
			
			// preloader
			preloader = new CirclePreloader();
			preloader.visible = true;
			addChild( preloader );
			
			// title
			titleField = TextUtils.createTextField( null, text, 30, StyleDict.RED1,
															false, false );
			titleField.autoSize = TextFieldAutoSize.LEFT;
			addChild( titleField );
		}
		
		/**
		 * Position child(ren) on display list.
		 */		
		protected function layout():void
		{
			// title
			if ( titleField )
			{
				titleField.x = 150;
				titleField.y = 7;
			}
			
			// preloader
			if ( preloader )
			{
				preloader.x = titleField.x + titleField.width + 30;
				preloader.y = (titleField.y + titleField.height/2) + 2;
			}
		}
		
		/**
		 * Remove and redraw child(ren).
		 */		
		protected function invalidate():void
		{
			if ( titleField )
			{
				removeChildFromDisplayList( titleField );
			}
			
			if ( preloader )
			{
				removeChildFromDisplayList( preloader );
			}
			
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