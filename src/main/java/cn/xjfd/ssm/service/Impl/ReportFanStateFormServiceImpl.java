package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.ReportFanStateFormMapper;
import cn.xjfd.ssm.pojo.FanStateData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.ReportFanStateFormService;

@Service
public class ReportFanStateFormServiceImpl implements ReportFanStateFormService{

	@Autowired
	ReportFanStateFormMapper reportFanStateFormMapper;
	
	@Override
	public List<FanStateData> getFanSta(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return reportFanStateFormMapper.getFanSta(queryPeriod);
	}

}
