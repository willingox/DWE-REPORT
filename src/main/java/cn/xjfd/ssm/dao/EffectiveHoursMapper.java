package cn.xjfd.ssm.dao;

import cn.xjfd.ssm.pojo.EffectiveHoursData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface EffectiveHoursMapper {

	public EffectiveHoursData getEffectiveHours(QueryPeriod queryPeriod);
}
