package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.EquipmentFailureData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface EquipmentFailureMapper {

	public List<EquipmentFailureData> getEquipmentFailure(QueryPeriod queryPeriod);
	
}
