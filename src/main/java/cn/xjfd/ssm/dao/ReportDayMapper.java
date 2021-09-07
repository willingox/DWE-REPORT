package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportDayData;

public interface ReportDayMapper {

	public List<ReportDayData> getReportDay(QueryPeriod queryPeriod);
	
	public List<ReportDayData> getReportDayYesterday(QueryPeriod queryPeriod);
	
}
