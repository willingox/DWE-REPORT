package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.HisStatisticalInfoMapper;
import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.HisStatisticalInfoService;
@Service
public class HisStatisticalInfoServiceImpl implements HisStatisticalInfoService{

	@Autowired
	HisStatisticalInfoMapper hisStatisticalInfoMapper;
	
	@Override
	public List<HisImportantData> getHisSta(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return hisStatisticalInfoMapper.getHisSta(queryPeriod);
	}

}
