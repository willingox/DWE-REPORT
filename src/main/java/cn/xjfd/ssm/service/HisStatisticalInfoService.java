package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface HisStatisticalInfoService {

	public List<HisImportantData> getHisSta(QueryPeriod queryPeriod);
}
