package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.GetOneMinColumnMapper;
import cn.xjfd.ssm.pojo.ColumnData;
import cn.xjfd.ssm.service.GetOneMinColumnService;
@Service
public class GetOneMinColumnServiceImpl implements GetOneMinColumnService{

	@Autowired
	GetOneMinColumnMapper getOneMinColumnMapper;
	
	@Override
	public List<ColumnData> getOneMinColumn() {
		// TODO Auto-generated method stub
		return getOneMinColumnMapper.getOneMinColumn();
	}

	@Override
	public List<ColumnData> getTenMinColumn() {
		// TODO Auto-generated method stub
		return getOneMinColumnMapper.getTenMinColumn();
	}

	@Override
	public List<ColumnData> getOneDayColumn() {
		// TODO Auto-generated method stub
		return getOneMinColumnMapper.getOneDayColumn();
	}

	
}
