package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface HisMeasureInfoMapper {

	public List<HisImportantData> getHisMea(QueryPeriod queryPeriod);
}
