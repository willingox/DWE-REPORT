package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportYearData;

public interface ReportYearService {

	public List<ReportYearData> getReportYear(QueryPeriod queryPeriod);
}
