package cn.xjfd.ssm.service;

import cn.xjfd.ssm.pojo.EffectiveHoursData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface EffectiveHoursService {

	public EffectiveHoursData getEffectiveHours(QueryPeriod queryPeriod);
}
