package com.examArrange.bean;

import org.omg.CORBA.INTERNAL;

import com.examArrange.res.Result;
import com.examArrange.bean.List;
import com.examArrange.bean.UserInfoBean;

import java.util.ArrayList;
import com.examArrange.*;
public class UserInfo extends List {
	ArrayList<UserInfoBean> list;

	public ArrayList<UserInfoBean> getList() {
		return list;
	}

	public void setList(ArrayList<UserInfoBean> list) {
		this.list = list;
	}
}