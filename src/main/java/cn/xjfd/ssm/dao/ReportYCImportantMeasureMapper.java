package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.YCReportData;

public interface ReportYCImportantMeasureMapper {

	public List<YCReportData> getYCImport(QueryPeriod queryPeriod);
}
