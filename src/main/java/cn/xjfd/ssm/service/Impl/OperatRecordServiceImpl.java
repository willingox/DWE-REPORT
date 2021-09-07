package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.OperatRecordMapper;
import cn.xjfd.ssm.pojo.OperatRecordData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.OperatRecordService;

@Service
public class OperatRecordServiceImpl implements OperatRecordService{

	@Autowired
	OperatRecordMapper operatRecordMapper;

	@Override
	public List<OperatRecordData> getOperatRecord(QueryPeriod queryPeriod) {
		
		return operatRecordMapper.getOperatRecord(queryPeriod);
	}
	
	
}
