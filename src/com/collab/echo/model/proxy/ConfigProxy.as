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
	import com.collab.echo.model.util.ConfigParser;
	import com.collab.echo.model.vo.ConfigVO;
	
	import org.osflash.thunderbolt.Logger;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
    /**
     * A <code>Proxy</code> that loads and stores the application configuration
     * XML file.
     * 
     * <p>The config file contains global configuration data as well as the
     * levels configuration.</p>
     * 
     * @author Thijs Triemstra
     */
    public class ConfigProxy extends Proxy implements IProxy
    {
    	// ====================================
		// CONSTANTS
		// ====================================
		
		/**
		 * Name of this <code>Proxy</code>.
		 */    	
		public static const NAME			: String = "ConfigProxy";
		
		// Notifications
		public static const LOAD_SUCCESSFUL	: String = NAME + "_loadSuccessful";
		public static const LOAD_FAILED		: String = NAME + "_loadFailed";
		
		// ====================================
		// PRIVATE VARS
		// ====================================
		
		private var _url					: String = 'xml/config.xml';
		
		private var _startup				: StartupMonitorProxy;
		private var _delegate 				: LoadXMLDelegate;
		
		// ====================================
		// GETTER/SETTER
		// ====================================
		
		/**
		 * @return 
		 */		
		public function get config():ConfigVO
		{
			return ConfigVO( data );
		}
		
		/**
		 * Constructor.
		 *  
		 * @param data
		 */		
		public function ConfigProxy ( data:Object = null ) 
        {
            super( NAME, data );
        }
		
		// ====================================
		// PUBLIC/PROTECTED METHODS
		// ====================================
		
		/**
		 * Retrieve proxies and reset data property.
		 */		
		override public function onRegister():void
		{		
			// retrieve the StartupMonitorProxy
			_startup = facade.retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
			
			// add the resource to load
			_startup.addResource( NAME, true );
			
			// reset the data 
			setData( new ConfigVO() );			
		}
		
		/**
		 * Load the configuration XML file.
		 * 
		 * <p>This method is called by the <code>StartupMonitorProxy</code>.</p>
		 */
		public function load():void
		{
			// create a worker who will go get some data
			// pass it handler references so the delegate knows
			// where to return the result/fault data
			_delegate = new LoadXMLDelegate( result, fault, _url );
			
			// make the delegate do some work
			_delegate.load();
		}
		
		/**
		 * This is called when the delegate receives a result from the service.
		 * 
		 * <p>Parses the configuration XML file and stores the <code>ConfigVO</code>
		 * in this <code>Proxy</code>.</p>
		 * 
         * @param result Configuration XML data
		 */
		public function result( result : Object ) : void
		{
			var config:ConfigVO = ConfigParser.parse( result );
			
			setData( config );
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
         * Get a config value.
		 * 
         * @param key the key to read 
         * @return String the key value stored in internal object
         */
		public function getValue( key:String ):String
		{
			return data[ key ];
		}
		
		/**
         * Get a config numeric value. 
		 * 
         * @param key the key to read 
         * @return Number the key value stored in internal object
         */
		public function getNumber( key:String ):Number
		{
			return Number( data[ key ] );
		}
		
		/**
         * Get a config boolean value.
		 * 
         * @param key the key to read 
         * @return Boolean the key value stored in internal object
         */
		public function getBoolean( key:String ):Boolean
		{
			return data[ key ] ? data[ key ] == "true" : false;
		}
		
		/**
         * Set a config value if isn't defined.
		 * 
         * @param key The key to set
         * @param value The value
         */
		public function setDefaultValue( key:String, value:Object ):void
		{
			if ( !data[ key ] )
			{
				data[ key ] = value;
			}
		}
		
		// ====================================
		// INTERNAL METHODS
		// ====================================
		
		/**
		 * Send the notifications when the resource has loaded.
		 */
		internal function resourceLoaded():void
		{
			// configure logging
			Logger.hide = !config.logging;
			
			// call the StartupMonitorProxy to notify that the resource has loaded
			_startup.resourceComplete( NAME );
			
			// send the successful notification
			sendNotification( LOAD_SUCCESSFUL );
		}
		
	}
}