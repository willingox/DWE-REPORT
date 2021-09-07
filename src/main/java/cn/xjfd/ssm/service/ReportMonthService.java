package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportMonthData;

public interface ReportMonthService {

	public List<ReportMonthData> getReportMonth(QueryPeriod queryPeriod);
}
