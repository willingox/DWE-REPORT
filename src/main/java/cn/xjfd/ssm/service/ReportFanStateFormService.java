package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.FanStateData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface ReportFanStateFormService {

	public List<FanStateData> getFanSta(QueryPeriod queryPeriod);
}
