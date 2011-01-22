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
	
	public class ProfileInfoVOTest
	{	
		private var dummy	: ProfileInfoVO;
		
		[Before]
		public function setUp():void
		{
			dummy = new ProfileInfoVO();
		}
		
		[After]
		public function tearDown():void
		{
			dummy = null;
		}
		
		[Test]
		public function testToString():void
		{
			var msg:String = "<ProfileInfoVO location='null'/>";
			
			assertThat( dummy.toString(), equalTo( dummy ));
		}
		
		[Test]
		public function testProfileInfoVO():void
		{
			assertThat( dummy.location, nullValue() );
			assertThat( dummy.website, nullValue() );
			assertThat( dummy.email, nullValue() );
			assertThat( dummy.age, nullValue() );
		}
	}
}