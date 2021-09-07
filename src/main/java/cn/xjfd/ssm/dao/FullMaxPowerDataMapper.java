package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.FullMaxPowerData;
import cn.xjfd.ssm.pojo.FullMaxPowerSingleData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface FullMaxPowerDataMapper {

	FullMaxPowerData getFullMaxPowerData(QueryPeriod queryPeriod);
	List<FullMaxPowerSingleData> getFullMaxPowerSingleData(QueryPeriod queryPeriod);
}
