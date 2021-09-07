package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.ReportDayMapper;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportDayData;
import cn.xjfd.ssm.service.ReportDayService;
@Service
public class ReportDayServiceImpl implements ReportDayService{

	@Autowired
	ReportDayMapper reportDayMapper;
	
	@Override
	public List<ReportDayData> getReportDay(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return reportDayMapper.getReportDay(queryPeriod);
	}

	@Override
	public List<ReportDayData> getReportDayYesterday(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return reportDayMapper.getReportDayYesterday(queryPeriod);
	}

}
