package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.FanStateData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface ReportFanStateFormMapper {

	public List<FanStateData> getFanSta(QueryPeriod queryPeriod);
}
