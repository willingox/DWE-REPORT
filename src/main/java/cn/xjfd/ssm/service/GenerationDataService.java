package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.dao.GenerationDataMapper;
import cn.xjfd.ssm.pojo.GenerationPageData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface GenerationDataService {

	
	
	List<GenerationPageData> getGenerationData(QueryPeriod queryPeriod);
}
