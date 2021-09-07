package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.ReportYearMapper;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportYearData;
import cn.xjfd.ssm.service.ReportYearService;
@Service
public class ReportYearServiceImpl implements ReportYearService{

	@Autowired
	ReportYearMapper reportYearMapper;
	
	@Override
	public List<ReportYearData> getReportYear(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return reportYearMapper.getReportYear(queryPeriod);
	}

}
