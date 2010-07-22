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
package com.collab.echo.model.business
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.thunderbolt.Logger;

	/**
	 * Delegate that can load XML files.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class LoadXMLDelegate
	{
		// ====================================
		// CONSTANTS
		// ====================================
		
		public static const ERROR_LOAD_FILE	: String	= "Error - could not load the XML file: ";
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _result	 				: Function;
		private var _fault	 				: Function;
		private var _service				: URLLoader;
		private var _url					: String;
		
		/**
		 * Constructor.
		 *  
		 * @param result
		 * @param fault
		 * @param url
		 */		
		public function LoadXMLDelegate( result : Function, fault : Function,
										 url:String ) 
		{
			_url = url;
			_result = result;
			_fault = fault;
			
			configureService();
		}

		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Start loading the XML file.
		 */		
		public function load() : void 
		{
			Logger.info( "Start loading XML file: " + _url );
			
			var request:URLRequest = new URLRequest( _url );
			_service.load( request );
		}
		
		// ====================================
		// PROTECTED METHODS
		// ====================================
		
		/**
		 * Setup service and listeners.
		 */		
		protected function configureService():void
		{
			_service = new URLLoader();
            _service.addEventListener( Event.COMPLETE, completeHandler,
									   false, 0, true );
            _service.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler,
            						   false, 0, true );
            _service.addEventListener( ProgressEvent.PROGRESS, progressHandler,
            						   false, 0, true );
        }

		// ====================================
		// EVENT HANDLERS
		// ====================================
		
        /**
         * @param event
         */		
        private function completeHandler( event:Event ):void
        {
        	event.target.removeEventListener( event.type, completeHandler );
            event.target.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
            
            Logger.debug( "Completed loading XML file: " + _url );
            Logger.debug( "" );
			
            _result( event.target.data );
        }

        /**
         * @param event
         */		
        private function ioErrorHandler( event:IOErrorEvent ):void
        {
        	event.target.removeEventListener( event.type, ioErrorHandler );
        	
        	Logger.error( "Error loading XML file: " + _url );
        	
            _fault( event.target.data );
        }

        /**
         * @param event
         */		
        private function progressHandler( event:ProgressEvent ):void
        {
            //trace("progressHandler: bytesLoaded=" + event.bytesLoaded +
			//  	" bytesTotal=" + event.bytesTotal);
        }

	}
}