package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface HisStatisticalInfoMapper {

	public List<HisImportantData> getHisSta(QueryPeriod queryPeriod);
}
