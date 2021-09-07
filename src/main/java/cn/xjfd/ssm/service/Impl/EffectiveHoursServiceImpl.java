package cn.xjfd.ssm.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.EffectiveHoursMapper;
import cn.xjfd.ssm.pojo.EffectiveHoursData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.EffectiveHoursService;
@Service
public class EffectiveHoursServiceImpl implements EffectiveHoursService{

	@Autowired
	EffectiveHoursMapper effectiveHoursMapper;
	
	@Override
	public EffectiveHoursData getEffectiveHours(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return effectiveHoursMapper.getEffectiveHours(queryPeriod);
	}

}
