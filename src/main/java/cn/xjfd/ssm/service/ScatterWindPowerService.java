package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ScatterWindPowerData;

public interface ScatterWindPowerService {

	public List<ScatterWindPowerData> getScatterWindPower(QueryPeriod queryPeriod);
}
