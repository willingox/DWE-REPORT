package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.GetWindNameMapper;
import cn.xjfd.ssm.pojo.WindGenerator;
import cn.xjfd.ssm.service.GetWindNameService;
@Service
public class GetWindNameServiceImpl implements GetWindNameService{

	@Autowired
	GetWindNameMapper getWindNameMapper;
	
	@Override
	public List<WindGenerator> getWindName() {
		
		return getWindNameMapper.getWindName();
	}

	@Override
	public List<Integer> getWindId() {
		
		return getWindNameMapper.getWindId();
	}

}
