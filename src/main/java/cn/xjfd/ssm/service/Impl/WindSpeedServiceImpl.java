package cn.xjfd.ssm.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.WindSpeedMapper;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.WindSpeedData;
import cn.xjfd.ssm.service.WindSpeedService;

@Service
public class WindSpeedServiceImpl implements WindSpeedService{

	@Autowired
	WindSpeedMapper windSpeedMapper;
	
	@Override
	public WindSpeedData getWindSpeed(QueryPeriod queryPeriod) {
		
		return windSpeedMapper.getWindSpeed(queryPeriod);
	}

}
