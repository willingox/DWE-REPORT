package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.HisMeasureInfoMapper;
import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.HisMeasureInfoService;
@Service
public class HisMeasureInfoServiceImpl implements HisMeasureInfoService{

	@Autowired
	HisMeasureInfoMapper hisMeasureInfoMapper;
	
	@Override
	public List<HisImportantData> getHisMea(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return hisMeasureInfoMapper.getHisMea(queryPeriod);
	}

}
