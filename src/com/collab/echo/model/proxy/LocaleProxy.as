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
package com.collab.echo.model.proxy
{
	import com.collab.echo.model.business.LoadXMLDelegate;
	import com.collab.echo.model.enum.ConfigKeyEnum;
	
	import org.osflash.thunderbolt.Logger;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
    /**
     * A proxy to read the locale file.
     * 
     * @author Thijs Triemstra
     */
    public class LocaleProxy extends Proxy implements IProxy
    {
    	// ====================================
		// CONSTANTS
		// ====================================
		
    	/**
		 * Name of this <code>Proxy</code>.
		 */ 
		public static const NAME			: String = "LocaleProxy";									

		// Notifications
		public static const LOAD_SUCCESSFUL	: String = NAME + "_loadSuccessful";
		public static const LOAD_FAILED		: String = NAME + "_loadFailed";
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _url					: String;
		private var _startup				: StartupMonitorProxy;
		private var _delegate 				: LoadXMLDelegate;
		
		/**
		 * Constructor.
		 *  
		 * @param data
		 */		
		public function LocaleProxy ( data:Object = null ) 
        {
            super ( NAME, data );
        }
		
		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================
		
		override public function onRegister():void
		{		
			// retrieve the StartupMonitorProxy
			_startup = facade.retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
			
			// add the resource to load
			_startup.addResource( NAME, true );
			
			// reset the data 
			setData ( new Object() );			
		}
		
		/**
		 * Load the xml file.
		 * 
		 * <p>This method is called by <code>StartupMonitorProxy</code>.</p>
		 */		
		public function load():void
		{
			var configProxy:ConfigProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
			var language:String = configProxy.getValue( ConfigKeyEnum.LANGUAGE );
			
			Logger.info( "Locale language: " + language );
			
			// check if the language is defined
			if ( language && language != "" )
			{
				_url = "xml/locale/" + language + '.xml';
				
				// create a worker who will go get some data
				// pass it a reference to this proxy so the delegate
				// knows where to return the data
				_delegate = new LoadXMLDelegate( result, fault, _url );
				
				// make the delegate do some work
				_delegate.load();
			}
			else
			{
				resourceLoaded();
			}
		}
		
		/**
		 * This is called when the delegate receives a result from the service.
		 * 
         * @param result XML locale data
		 */
		public function result( result : Object ) : void
		{
			var items:XMLList = XML( result ).item;
			var locale:Object = {};

			// parse XML
			for (var d:int=0; d<items.length(); d++)
			{
				locale[ items[d].@name ] = items[ d ];
			}
			
			setData( locale );
			resourceLoaded();
		}
		
		/**
		 * This is called when the delegate receives a fault from the service.
		 * 
         * @param fault
		 */
		public function fault( fault : Object ) : void 
		{
			var errorMessage:String = LoadXMLDelegate.ERROR_LOAD_FILE + _url;
			
			// send the failed notification
			sendNotification( LOAD_FAILED, errorMessage );
		}

		/**
         * Get the localized text.
		 * 
         * @param key the key to read
         * @return String the text value stored in internal object
         */
		public function getText( key:String ):String
		{
			return data[ key ];
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * Send the notifications when the resource has loaded.
		 */
		internal function resourceLoaded():void
		{
			// call the StartupMonitorProxy for notify that the resource is
			// loaded
			_startup.resourceComplete( NAME );
			
			// send the successful notification
			sendNotification( LOAD_SUCCESSFUL );
		}
		
	}
}