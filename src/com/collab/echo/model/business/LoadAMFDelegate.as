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
	import com.collab.echo.model.business.events.LoadAMFEvent;
	import com.collab.echo.util.StringUtil;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import org.osflash.thunderbolt.Logger;

	/**
	 * Delegate that can make AMF requests.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class LoadAMFDelegate extends EventDispatcher
	{
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var url					: String;
		private var servicePath			: String;
		private var resp	 			: Responder;
		private var service				: NetConnection;
		
		/**
		 * Constructor.
		 */		
		public function LoadAMFDelegate( url:String, servicePath:String ) 
		{
			super();
			
			this.url = url;
			this.servicePath = servicePath;
			
			configureService();
		}

		// ====================================
		// PUBLIC METHODS
		// ====================================
		
		/**
		 * Make a request for a remote method.
		 *  
		 * @param args Optional parameters
		 */		
		public function load( ...args:Array ) : void 
		{
			var msg:String = "Start AMF service request: " + servicePath + "(%s)";
			
			if ( args.length > 0 )
			{
				msg = StringUtil.replace( msg, [ args.toString() ]);
			}
			else
			{
				msg = StringUtil.replace( msg, '' );
			}
			
			Logger.debug( msg );
			
			if ( url )
			{
				dispatchEvent( new LoadAMFEvent( LoadAMFEvent.LOAD ));
					
				resp = new Responder( resultHandler, faultHandler );
				service.call.apply( service, [ servicePath, resp ].concat( args ));
			}
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * Setup service and listeners.
		 */		
		protected function configureService():void
		{
			service = new NetConnection();
			service.addEventListener( NetStatusEvent.NET_STATUS, statusHandler,
									  false, 0, true );
            service.addEventListener( AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler,
            						  false, 0, true );
			service.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler,
									  false, 0, true );
            service.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityHandler,
            						  false, 0, true );
			service.connect( url );
        }

        /**
         * @param result
         */		
		protected function resultHandler( result:Object ):void
        {
			var evt:LoadAMFEvent = new LoadAMFEvent( LoadAMFEvent.COMPLETE );
			evt.result = result;
			
			Logger.debug( "Completed loading AMF response." );
			
			dispatchEvent( evt );
			dispose();
        }

		/**
		 * @param error
		 */		
		protected function faultHandler( error:Object=null ):void
		{
			Logger.error( "Error loading AMF response." );
			
			var evt:LoadAMFEvent = new LoadAMFEvent( LoadAMFEvent.ERROR );
			evt.error = error;
			
			dispatchEvent( evt );
			dispose();
		}
		
		protected function dispose():void
		{
			service = null;
			url = null;
			servicePath = null;
			resp = null;
		}
		
		// ====================================
		// EVENT HANDLERS
		// ====================================
		
		/**
		 * @param event
		 */		
		protected function statusHandler( event:NetStatusEvent ):void
		{
			event.stopImmediatePropagation();
			event.target.removeEventListener( event.type, statusHandler );
			
			Logger.debug( "NetStatus Error encountered while loading AMF response: " + url );
			
			faultHandler( event.info );
		}
		
        /**
         * @param event
         */		
		protected function ioErrorHandler( event:IOErrorEvent ):void
        {
			event.stopImmediatePropagation();
        	event.target.removeEventListener( event.type, ioErrorHandler );
        	
        	Logger.error( "I/O Error encountered while loading AMF response: " + url );
        	
			faultHandler( event );
        }
		
		/**
		 * @param event
		 */		
		protected function asyncErrorHandler( event:AsyncErrorEvent ):void
		{
			event.stopImmediatePropagation();
			event.target.removeEventListener( event.type, asyncErrorHandler );
			
			Logger.error( "Async Error encountered while loading AMF response: " + url );
			
			faultHandler( event );
		}
		
		/**
		 * @param event
		 */		
		protected function securityHandler( event:SecurityErrorEvent ):void
		{
			event.stopImmediatePropagation();
			event.target.removeEventListener( event.type, securityHandler );
			
			Logger.error( "Security error while loading AMF response: " + url );
			
			faultHandler( event );
		}

	}
}