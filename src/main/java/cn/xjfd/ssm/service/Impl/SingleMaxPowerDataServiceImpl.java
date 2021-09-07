package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.SingleMaxPowerDataMapper;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.SingleMaxPowerData;
import cn.xjfd.ssm.service.SingleMaxPowerDataService;

@Service
public class SingleMaxPowerDataServiceImpl implements SingleMaxPowerDataService{

	@Autowired
	SingleMaxPowerDataMapper singleMaxPowerDataMapper;
	
	@Override
	public List<Integer> getWindId() {
		// TODO Auto-generated method stub
		return singleMaxPowerDataMapper.getWindId();
	}

	@Override
	public SingleMaxPowerData getSMaxPowerData(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return singleMaxPowerDataMapper.getSMaxPowerData(queryPeriod);
	}

	


	
	

}
