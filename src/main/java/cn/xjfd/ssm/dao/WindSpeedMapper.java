package cn.xjfd.ssm.dao;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.WindSpeedData;

public interface WindSpeedMapper {

	public WindSpeedData getWindSpeed(QueryPeriod queryPeriod);
}
