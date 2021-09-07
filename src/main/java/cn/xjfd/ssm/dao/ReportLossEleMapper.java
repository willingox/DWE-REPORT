package cn.xjfd.ssm.dao;

import cn.xjfd.ssm.pojo.ReportLossEleData;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;


public interface ReportLossEleMapper {
	public List<ReportLossEleData> getReportLossEle(QueryPeriod queryPeriod);
}
