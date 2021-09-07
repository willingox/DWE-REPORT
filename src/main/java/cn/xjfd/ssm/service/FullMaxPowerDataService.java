package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.FullMaxPowerData;
import cn.xjfd.ssm.pojo.FullMaxPowerSingleData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface FullMaxPowerDataService {

	FullMaxPowerData getFullMaxPowerData(QueryPeriod queryPeriod);
	List<FullMaxPowerSingleData> getFullMaxPowerSingleData(QueryPeriod queryPeriod);
}
