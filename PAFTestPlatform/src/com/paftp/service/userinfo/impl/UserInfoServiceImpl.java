package com.paftp.service.userinfo.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.paftp.dao.BaseDAO;
import com.paftp.entity.UserInfo;
import com.paftp.service.userinfo.UserInfoService;

@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {

	@Resource
	private BaseDAO<UserInfo> baseDAO;

	@Override
	public void saveUserInfo(UserInfo userinfo) {
		baseDAO.save(userinfo);
	}

	@Override
	public void updateUserInfo(UserInfo userinfo) {
		baseDAO.update(userinfo);
	}

	@Override
	public UserInfo findUserInfoById(int id) {
		return baseDAO.get(UserInfo.class, id);
	}

	

}
