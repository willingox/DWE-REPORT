package cn.xjfd.ssm.dao;

import java.util.List;

import cn.xjfd.ssm.pojo.ColumnData;

public interface GetOneMinColumnMapper {

	public List<ColumnData> getOneMinColumn();
	public List<ColumnData> getTenMinColumn();
	public List<ColumnData> getOneDayColumn();
	
}
