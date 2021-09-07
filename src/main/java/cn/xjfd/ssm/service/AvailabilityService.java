package cn.xjfd.ssm.service;

import cn.xjfd.ssm.pojo.FailDownData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface AvailabilityService {

	public FailDownData getFailDownTime(QueryPeriod queryPeriod);

}
