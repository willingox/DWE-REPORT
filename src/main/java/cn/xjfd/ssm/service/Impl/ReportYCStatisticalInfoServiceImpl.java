package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.ReportYCStatisticalInfoMapper;
import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.YCReportData;
import cn.xjfd.ssm.service.ReportYCStatisticalInfoService;

@Service
public class ReportYCStatisticalInfoServiceImpl implements ReportYCStatisticalInfoService{

	@Autowired
	ReportYCStatisticalInfoMapper reportYCStatisticalInfoMapper;
	
	@Override
	public List<YCReportData> getYCSta(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return reportYCStatisticalInfoMapper.getYCSta(queryPeriod);
	}

}
