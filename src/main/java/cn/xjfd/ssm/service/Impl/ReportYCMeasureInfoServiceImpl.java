package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.ReportYCMeasureInfoMapper;
import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.YCReportData;
import cn.xjfd.ssm.service.ReportYCMeasureInfoService;

@Service
public class ReportYCMeasureInfoServiceImpl implements ReportYCMeasureInfoService{

	@Autowired
	ReportYCMeasureInfoMapper reportYCMeasureInfoMapper;
	
	@Override
	public List<YCReportData> getYCMea(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return reportYCMeasureInfoMapper.getYCMea(queryPeriod);
	}

	
}
