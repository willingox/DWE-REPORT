package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.HisImportantMeasureMapper;
import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.HisImportantMeasureService;
@Service
public class HisImportantMeasureServiceImpl implements HisImportantMeasureService{

	@Autowired
	HisImportantMeasureMapper hisImportantMeasureMapper;
	
	@Override
	public List<HisImportantData> getHisImportant(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return hisImportantMeasureMapper.getHisImportant(queryPeriod);
	}

}
