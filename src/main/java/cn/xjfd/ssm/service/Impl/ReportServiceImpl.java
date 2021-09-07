package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.ReportMapper;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportData;
import cn.xjfd.ssm.service.ReportService;

@Service
public class ReportServiceImpl implements ReportService{

	@Autowired
	ReportMapper reportMapper;
	
	@Override
	public List<ReportData> getReport(QueryPeriod queryPeriod) {
		
		return reportMapper.getReport(queryPeriod);
	}

}
