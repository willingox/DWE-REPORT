package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.GenerationDataMapper;
import cn.xjfd.ssm.pojo.GenerationPageData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.GenerationDataService;
@Service
public class GenerationDataServiceImpl implements GenerationDataService{
	@Autowired
	GenerationDataMapper generationDataMapper;

	@Override
	public List<GenerationPageData> getGenerationData(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return generationDataMapper.getGenerationData(queryPeriod);
	}
	
	
}
