package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportMonthData;

public interface ReportMonthMapper {

	public List<ReportMonthData> getReportMonth(QueryPeriod queryPeriod);
}
