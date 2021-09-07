package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.ScatterWindPowerMapper;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ScatterWindPowerData;
import cn.xjfd.ssm.service.ScatterWindPowerService;
@Service
public class ScatterWindPowerServiceImpl implements ScatterWindPowerService{

	@Autowired
	ScatterWindPowerMapper scatterWindPowerMapper;
	
	@Override
	public List<ScatterWindPowerData> getScatterWindPower(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return scatterWindPowerMapper.getScatterWindPower(queryPeriod);
	}

}
