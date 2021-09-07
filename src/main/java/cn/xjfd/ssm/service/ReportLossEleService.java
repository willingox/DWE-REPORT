package cn.xjfd.ssm.service;

import cn.xjfd.ssm.pojo.ReportLossEleData;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;

public interface ReportLossEleService {
	public List<ReportLossEleData> getReportLossEle(QueryPeriod queryPeriod);

}
