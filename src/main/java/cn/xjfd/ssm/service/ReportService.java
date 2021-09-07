package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportData;

public interface ReportService {

	public List<ReportData> getReport(QueryPeriod queryPeriod);
}
