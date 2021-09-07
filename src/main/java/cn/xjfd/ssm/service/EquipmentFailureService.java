package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.EquipmentFailureData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface EquipmentFailureService {

	public List<EquipmentFailureData> getEquipmentFailure(QueryPeriod queryPeriod);
}
