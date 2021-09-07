package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.WindRoseData;

public interface WindRoseService {

	public List<WindRoseData> getWindRoseData(QueryPeriod queryPeriod);
}
