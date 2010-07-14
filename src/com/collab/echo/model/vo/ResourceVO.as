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
	 * Data object for a XML resource.
	 * 
	 * @author Thijs Triemstra
	 */	
	public class ResourceVO
	{
		public var proxyName	: String;
		public var loaded		: Boolean;
		public var blockChain	: Boolean;
		
		/**
		 * Constructor.
		 *  
		 * @param proxyName
		 * @param blockChain
		 */		
		public function ResourceVO( proxyName:String, blockChain:Boolean )
		{
			this.proxyName = proxyName;
			this.blockChain = blockChain;
			this.loaded = false;
		}
		
		public function toString() : String
		{
			return "<ResourceVO proxyName='" + proxyName + "' blockChain='" + blockChain +
				   "' loaded='" + loaded + "' />";
		}
		
	}
}