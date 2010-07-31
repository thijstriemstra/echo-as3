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
package com.collab.echo.model.util
{
	import com.collab.site.common.model.enum.ConfigKeyEnum;
	import com.collab.site.common.model.vo.ConfigVO;

	/**
	 * Helper class that parses the game's configuration XML and stores
	 * the data in a <code>ConfigVO</code> object.
	 * 
	 * @see com.collab.echo.model.vo.ConfigVO ConfigVO
	 * @author Thijs Triemstra
	 */	
	public class ConfigParser
	{
		// ====================================
		// PUBLIC STATIC METHODS
		// ====================================
		
		/**
		 * Parse configuration XML and return a <code>ConfigVO</code>.
		 *  
		 * @param data Configuration XML data
		 * @return ConfigVO
		 */		
		public static function parse( data:Object ) : ConfigVO
		{
			var config:ConfigVO = new ConfigVO();
			var items:XMLList = XML( data ).param;
			
			// parse XML data
			config.logging = ( getValue( data, ConfigKeyEnum.LOGGING ) == "true" );
			config.gateway = getValue( data, ConfigKeyEnum.GATEWAY );
			config.servicePath = getValue( data, ConfigKeyEnum.SERVICE_PATH );
			config.presenceHost = getValue( data, ConfigKeyEnum.PRESENCE_HOST );
			config.presencePort = int( getValue( data, ConfigKeyEnum.PRESENCE_PORT ));
			
			for ( var d:int=0; d<items.length(); d++ )
			{
				var title:String = items[ d ].@name;
				var path:String = items[ d ].@path;
				
				switch ( title )
				{
					default:
						// general options
						try
						{
							if ( title == ConfigKeyEnum.LANGUAGE )
							{
								config[ title ] = items[ d ];
							}
						}
						catch ( e:ReferenceError )
						{
							throw new ReferenceError( "Failed to parse config.xml - " +
													  e.message.substr( 6 ));
						}
						break;
				}
			}

			return config;
		}
		
		// ====================================
		// PRIVATE STATIC METHODS
		// ====================================
		
		/**
		 * @param data
		 * @param key
		 * @return
		 */		
		private static function getValue( data:Object, key:String ):String
		{
			return XML( data ).param.( @name==key );
		}
		
	}
}