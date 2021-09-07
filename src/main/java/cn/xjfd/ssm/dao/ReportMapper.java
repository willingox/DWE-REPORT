package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportData;

public interface ReportMapper {

	public List<ReportData> getReport(QueryPeriod queryPeriod);
}
