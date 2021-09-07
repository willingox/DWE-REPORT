package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.SingleMaxPowerData;

public interface SingleMaxPowerDataMapper {

	public List<Integer> getWindId();
	
	public SingleMaxPowerData getSMaxPowerData(QueryPeriod queryPeriod);
}
