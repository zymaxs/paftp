package com.paftp.service.userinfo;


import com.paftp.entity.UserInfo;

public interface UserInfoService {

	public void saveUserInfo(UserInfo userinfo);

	public void updateUserInfo(UserInfo userinfo);

	public UserInfo findUserInfoById(int id);

}
