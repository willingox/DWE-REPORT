package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.WindRoseData;

public interface WindRoseMapper {

	public List<WindRoseData> getWindRoseData(QueryPeriod queryPeriod);
}
