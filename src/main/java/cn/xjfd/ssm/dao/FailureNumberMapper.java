package cn.xjfd.ssm.dao;

import cn.xjfd.ssm.pojo.FailureNumberData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface FailureNumberMapper {

	public FailureNumberData getFailureNumber(QueryPeriod queryPeriod);
}
