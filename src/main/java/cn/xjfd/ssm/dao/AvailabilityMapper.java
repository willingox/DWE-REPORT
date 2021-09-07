package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.FailDownData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface AvailabilityMapper {

	public int getFailDownData_OccurredNotReturned(QueryPeriod queryPeriod);
	public List<FailDownData> getFailDownData_OccurredAndReturned(QueryPeriod queryPeriod);
	public List<FailDownData> getFailDownData_NotOccurredAndReturned(QueryPeriod queryPeriod);
	public List<FailDownData> getFailDownData_NotOccurredNotReturned(QueryPeriod queryPeriod);
}
