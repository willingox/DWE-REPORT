package cn.xjfd.ssm.service.Impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.UserMapper;
import cn.xjfd.ssm.pojo.User;
import cn.xjfd.ssm.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Resource
	private UserMapper userMapper;

	public User getLogin(String username) {
		// TODO Auto-generated method stub
		return userMapper.selectLogin(username);
	}

}
