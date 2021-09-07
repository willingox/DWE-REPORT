package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.EquipmentFailureMapper;
import cn.xjfd.ssm.pojo.EquipmentFailureData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.EquipmentFailureService;
@Service
public class EquipmentFailureServiceImpl implements EquipmentFailureService{

	@Autowired
	EquipmentFailureMapper equipmentFailureMapper;
	
	@Override
	public List<EquipmentFailureData> getEquipmentFailure(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return equipmentFailureMapper.getEquipmentFailure(queryPeriod);
	}

}
