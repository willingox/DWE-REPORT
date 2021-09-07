package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.WindGenerator;

public interface GetWindNameMapper {

	public List<WindGenerator> getWindName();
	
	public List<Integer> getWindId();
	
}
