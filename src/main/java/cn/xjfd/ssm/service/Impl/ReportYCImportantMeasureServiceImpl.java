package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.ReportYCImportantMeasureMapper;
import cn.xjfd.ssm.pojo.HisImportantData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.YCReportData;
import cn.xjfd.ssm.service.ReportYCImportantMeasureService;
@Service
public class ReportYCImportantMeasureServiceImpl implements ReportYCImportantMeasureService{

	@Autowired
	ReportYCImportantMeasureMapper reportYCImportantMeasureMapper;
	
	@Override
	public List<YCReportData> getYCImport(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return reportYCImportantMeasureMapper.getYCImport(queryPeriod);
	}

}
