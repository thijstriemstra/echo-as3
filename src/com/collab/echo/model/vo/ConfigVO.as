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
package com.collab.echo.model.vo
{
	/**
	 * Actionscript object of the config.xml.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class ConfigVO
	{
		/**
		 * Language ISO code. Eg. 'en'. 
		 */		
		public var language					: String;
		
		/**
		 * Enable logging.
		 * 
		 * <p>Disable in production builds.</p>
		 */		
		public var logging					: Boolean;
		
		/**
		 * Remoting gateway URL. 
		 */		
		public var gateway					: String;
		
		/**
		 * Remoting service path.
		 */		
		public var servicePath				: String;
		
		/**
		 * 
		 */		
		public var presenceHost				: String;
		
		/**
		 * 
		 */		
		public var presencePort				: int;
		
		/**
		 * Constructor.
		 *  
		 * @param language
		 * @param logging
		 * @param gateway
		 * @param servicePath
		 * @param presenceHost
		 * @param presencePort
		 */		
		public function ConfigVO( language:String="en", logging:Boolean=false,
								  gateway:String="http://localhost:8000",
								  servicePath:String=null, presenceHost:String="tryunion.com",
								  presencePort:int=80 )
		{
			this.language = language;
			this.logging = logging;
			this.gateway = gateway;
			this.servicePath = servicePath;
			this.presenceHost = presenceHost;
			this.presencePort = presencePort;
		}

		public function toString() : String
		{
			return "<ConfigVO language='" + language + "' logging='" + logging + "' " +
				   "gateway='" + gateway + "' presenceHost='" + presenceHost + "'/>";
		}
		
	}
}