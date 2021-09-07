package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ScatterWindPowerData;

public interface ScatterWindPowerMapper {

	public List<ScatterWindPowerData> getScatterWindPower(QueryPeriod queryPeriod);
}
