package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.SingleMaxPowerData;

public interface SingleMaxPowerDataService {

	public List<Integer> getWindId();
	
	public SingleMaxPowerData getSMaxPowerData(QueryPeriod queryPeriod);
}
