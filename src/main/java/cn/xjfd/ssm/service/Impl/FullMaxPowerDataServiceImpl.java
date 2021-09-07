package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.FullMaxPowerDataMapper;
import cn.xjfd.ssm.pojo.FullMaxPowerData;
import cn.xjfd.ssm.pojo.FullMaxPowerSingleData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.FullMaxPowerDataService;
@Service
public class FullMaxPowerDataServiceImpl implements FullMaxPowerDataService{

	@Autowired
	FullMaxPowerDataMapper fullMaxPowerDataMapper;
	
	@Override
	public FullMaxPowerData getFullMaxPowerData(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return fullMaxPowerDataMapper.getFullMaxPowerData(queryPeriod);
	}

	@Override
	public List<FullMaxPowerSingleData> getFullMaxPowerSingleData(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return fullMaxPowerDataMapper.getFullMaxPowerSingleData(queryPeriod);
	}

	
}
