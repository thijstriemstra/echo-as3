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
	 * @author Thijs Triemstra
	 * 
	 * @langversion 3.0
 	 * @playerversion Flash 9
	 */	
	public class ProfileInfoVO extends SAObject
	{
		public var location	: String;
		public var website	: String;
		public var email	: String;
		public var age		: String;
		
		/**
		 * Constructor.
		 *  
		 * @param location
		 * @param website
		 * @param email
		 * @param age
		 */		
		public function ProfileInfoVO( location:String=null, website:String=null,
									email:String=null, age:String=null )
		{
			this.location = location;
			this.website = website;
			this.email = email;
			this.age = age;
		}
		
		public function toString():String
		{
			return "<ProfileInfoVO location='" + location + "'/>";
		}
		
	}
}