package cn.xjfd.ssm.dao;

import cn.xjfd.ssm.pojo.User;

public interface UserMapper {
	public User selectLogin(String username);

}
