/*
Echo project.

Copyright (C) 2011 Collab

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
package com.collab.echo.model
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	
	public class UserVOTest
	{	
		private var user	: UserVO;
		
		[Before]
		public function setUp():void
		{
			user = new UserVO();
		}
		
		[After]
		public function tearDown():void
		{
			user = null;
		}
		
		[Test]
		public function testToString():void
		{
			var msg:String = "<UserVO id='1' username='User1' rank='guest'/>";
			
			assertThat( user.toString(), equalTo( msg ));
		}
		
		[Test]
		public function testUserVO():void
		{
			assertThat( user.id, equalTo( '1' ));
			assertThat( user.username, equalTo( 'User1' ));
			assertThat( user.rank, equalTo( 'guest' ) );
			
			assertThat( user.location, nullValue() );
			assertThat( user.website, nullValue() );
			assertThat( user.email, nullValue() );
			assertThat( user.age, nullValue() );
			assertThat( user.client, nullValue() );
			
			// XXX: keys for union
			assertThat( UserVO.USERNAME, equalTo( "username" ));
			assertThat( UserVO.LOCATION, equalTo( "location" ));
			assertThat( UserVO.WEBSITE, equalTo( "website" ));
			assertThat( UserVO.EMAIL, equalTo( "email" ));
			assertThat( UserVO.AGE, equalTo( "age" ));
			assertThat( UserVO.RANK, equalTo( "rank" ));
		}
	}
}