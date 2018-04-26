package com.examArrange.bean;

import org.omg.CORBA.INTERNAL;

import com.examArrange.res.Result;

import java.util.ArrayList;

public class UserInfoBean extends Result{
    private String id;
    private String userName;
    private String phone;
    private String collegeId;
    private String classId;
    private String sex;
    private String birthday;
    private String password;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCollegeId() {
		return collegeId;
	}
	public void setCollegeId(String collegeId) {
		this.collegeId = collegeId;
	}
	public String getClassId() {
		return classId;
	}
	public void setClassId(String classId) {
		this.classId = classId;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

    
//    @Override
//	public String toString() {
//		return "UserInfo [feedbackId=" + feedbackId + ", status=" + status + ", userId=" + userId + ", userName="
//				+ userName + ", role=" + role + "]";
//	}

	


}

