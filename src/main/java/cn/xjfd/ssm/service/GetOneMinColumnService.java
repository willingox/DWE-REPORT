package cn.xjfd.ssm.service;

import java.util.List;

import cn.xjfd.ssm.pojo.ColumnData;

public interface GetOneMinColumnService {

	public List<ColumnData> getOneMinColumn();
	public List<ColumnData> getTenMinColumn();
	public List<ColumnData> getOneDayColumn();
	
}
