package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.YCReportData;

public interface ReportYCMeasureInfoService {

	public List<YCReportData> getYCMea(QueryPeriod queryPeriod);
}
