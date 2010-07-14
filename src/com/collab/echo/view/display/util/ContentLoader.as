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
package com.collab.echo.view.display.util
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import org.osflash.thunderbolt.Logger;
		
	/**
	 * Content loader.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class ContentLoader extends Loader
	{
		internal var url	: String;

		/**
		 * Constructor.
		 *  
		 * @param url Absolute or relative url of a piece of media.
		 */		
		public function ContentLoader( url:String=null )
		{
			super();
			
			this.url = url;

			configureListeners( contentLoaderInfo );
			
			var request:URLRequest = new URLRequest( url );
			load( request );
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * Listen for loader events.
		 * 
		 * @param dispatcher
		 */		
		internal function configureListeners( dispatcher:IEventDispatcher ):void
		{
			dispatcher.addEventListener( Event.COMPLETE, completeHandler, false, 0, true );
			dispatcher.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );
			dispatcher.addEventListener( Event.OPEN, openHandler, false, 0, true );
			dispatcher.addEventListener( ProgressEvent.PROGRESS, progressHandler, false, 0, true );
		}
		
		// =========================
		// EVENT HANDLERS
		// =========================
		
		/**
		 * @param event
		 */		
		internal function completeHandler( event:Event ):void
		{
			Logger.debug( "ContentLoader - Completed loading: " + url );
		}
		
		/**
		 * @param event
		 */		
		internal function ioErrorHandler( event:IOErrorEvent ):void
		{
			Logger.error( "ContentLoader - " + url + " - " + event.text );
		}
		
		/**
		 * @param event
		 */		
		internal function openHandler( event:Event ):void
		{
			Logger.info( "ContentLoader - Loading: " + url );

			dispatchEvent( event );
		}
		
		/**
		 * @param event
		 */		
		internal function progressHandler( event:ProgressEvent ):void
		{
			//Logger.debug( "Loading " + url + " - " + event.bytesLoaded + "/" +
			//			  event.bytesTotal + " bytes" );

			dispatchEvent( event );
		}
		
	}
}