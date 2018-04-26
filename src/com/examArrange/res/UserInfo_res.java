package com.examArrange.res;

import org.omg.CORBA.INTERNAL;

import com.examArrange.res.Result;
import com.examArrange.bean.UserInfo;


public class UserInfo_res extends Result{
	private UserInfo data;

	public UserInfo getData() {
		return data;
	}

	public void setData(UserInfo data) {
		this.data = data;
	}
	


}

