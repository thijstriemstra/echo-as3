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
	 */	
	public class UserVO extends SAObject
	{
		// keys for union
		public static const USERNAME	: String = "username";
		public static const LOCATION	: String = "location";
		public static const WEBSITE		: String = "website";
		public static const EMAIL		: String = "email";
		public static const AGE			: String = "age";
		
		// ====================================
		// PUBLIC VARS
		// ====================================
		
		public var id					: String;
		public var username				: String;
		public var location				: String;
		public var website				: String;
		public var email				: String;
		public var age					: String;
		public var client				: *;
		public var fields				: Array = [ USERNAME, LOCATION, WEBSITE, EMAIL, AGE ];
		
		/**
		 * Constructor.
		 *  
		 * @param id
		 * @param username
		 * @param location
		 * @param website
		 * @param email
		 * @param age
		 * @param client
		 */		
		public function UserVO( id:String="1", username:String="User1", location:String=null, website:String=null,
								email:String=null, age:String=null, client:*=null )
		{
			this.id = id;
			this.username = username;
			this.location = location;
			this.website = website;
			this.email = email;
			this.age = age;
			this.client = client;
		}
		
		public function toString():String
		{
			return "<UserVO id='" + id + "' username='" + username + "' location='" + location + "'/>";
		}
		
	}
}