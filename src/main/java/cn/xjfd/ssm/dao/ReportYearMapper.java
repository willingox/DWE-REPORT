package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportYearData;

public interface ReportYearMapper {

	public List<ReportYearData> getReportYear(QueryPeriod queryPeriod);
}
