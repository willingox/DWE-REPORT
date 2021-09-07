package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.WindSpeedData;

public interface WindSpeedService {

	public WindSpeedData getWindSpeed(QueryPeriod queryPeriod);
}
