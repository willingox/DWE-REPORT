package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportDayData;

public interface ReportDayService {

	public List<ReportDayData> getReportDay(QueryPeriod queryPeriod);
	
	public List<ReportDayData> getReportDayYesterday(QueryPeriod queryPeriod);
	
	
}
