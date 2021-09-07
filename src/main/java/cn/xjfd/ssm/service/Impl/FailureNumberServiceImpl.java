package cn.xjfd.ssm.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.FailureNumberMapper;
import cn.xjfd.ssm.pojo.FailureNumberData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.FailureNumberService;

@Service
public class FailureNumberServiceImpl implements FailureNumberService{

	@Autowired
	FailureNumberMapper failureNumberMapper;

	@Override
	public FailureNumberData getFailureNumber(QueryPeriod queryPeriod) {
		
		return failureNumberMapper.getFailureNumber(queryPeriod);
	}
	
	
}
