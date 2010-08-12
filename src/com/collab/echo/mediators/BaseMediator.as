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
package com.collab.echo.mediators
{
	import com.collab.echo.events.ViewEvent;
	import com.collab.echo.model.proxy.PresenceProxy;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	/**
	 * Base Mediator.
	 *  
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class BaseMediator extends Mediator implements IMediator
	{
		// ====================================
		// PROTECTED VARS
		// ====================================
		
		/**
		 * Presence data. 
		 */        
		protected var presence		: PresenceProxy;
		
		/**
		 * Constructor.
		 * 
		 * @param name
		 * @param viewComponent
		 */        
		public function BaseMediator( name:String, viewComponent:Object )
		{
			// pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
			super( name, viewComponent );
		}
		
		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Add listeners for view events and retrieve common proxies.
		 */		
		override public function onRegister():void
		{
			// retrieve the common proxies
			presence = facade.retrieveProxy( PresenceProxy.NAME ) as PresenceProxy;
			
			// listen for events
			viewComponent.addEventListener( ViewEvent.CREATION_COMPLETE, onCreationComplete,
								       	    false, 0, true );
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
         * Created view.
         * 
         * @param event
         */
		protected function onCreationComplete( event:Event=null ):void
		{
			// remove listener
			if ( event && viewComponent.hasEventListener( event.type ))
			{
				viewComponent.removeEventListener( event.type, onCreationComplete );
			}
		}
		
	}
}