package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.ReportMapper;
import cn.xjfd.ssm.dao.ReportMonthMapper;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportMonthData;
import cn.xjfd.ssm.service.ReportMonthService;
@Service
public class ReportMonthServiceImpl implements ReportMonthService{

	@Autowired
	ReportMonthMapper reportMonthMapper;
	
	@Override
	public List<ReportMonthData> getReportMonth(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return reportMonthMapper.getReportMonth(queryPeriod);
	}

}
