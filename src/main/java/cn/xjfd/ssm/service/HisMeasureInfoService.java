package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface HisMeasureInfoService {

	public List<HisImportantData> getHisMea(QueryPeriod queryPeriod);
}
