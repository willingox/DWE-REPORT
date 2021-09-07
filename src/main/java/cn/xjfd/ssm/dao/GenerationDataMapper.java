package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.GenerationPageData;
import cn.xjfd.ssm.pojo.QueryPeriod;

public interface GenerationDataMapper {

	List<GenerationPageData> getGenerationData(QueryPeriod queryPeriod);
}
