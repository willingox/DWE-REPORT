package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.ReportLossEleMapper;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportLossEleData;
import cn.xjfd.ssm.service.ReportLossEleService;

@Service
public class ReportLossEleServiceImpl implements ReportLossEleService {
	
	@Autowired
	ReportLossEleMapper reportLossEleMapper;

	@Override
	public List<ReportLossEleData> getReportLossEle(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return reportLossEleMapper.getReportLossEle(queryPeriod);
	}

}
