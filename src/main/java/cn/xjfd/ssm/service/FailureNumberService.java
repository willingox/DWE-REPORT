package cn.xjfd.ssm.service;

import cn.xjfd.ssm.pojo.FailureNumberData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface FailureNumberService {

	public FailureNumberData getFailureNumber(QueryPeriod queryPeriod);
}
