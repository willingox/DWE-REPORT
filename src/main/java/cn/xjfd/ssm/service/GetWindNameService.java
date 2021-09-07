package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.WindGenerator;

public interface GetWindNameService {

	public List<WindGenerator> getWindName();
	
	public List<Integer> getWindId();
}
