package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.AvailabilityMapper;
import cn.xjfd.ssm.pojo.FailDownData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.AvailabilityService11111;
@Service
public class AvailabilityServiceImpl11111 implements AvailabilityService11111{

	@Autowired
	AvailabilityMapper availabilityMapper;

	@Override
	public int getFailDownData_OccurredNotReturned(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return availabilityMapper.getFailDownData_OccurredNotReturned(queryPeriod);
	}

	@Override
	public List<FailDownData> getFailDownData_OccurredAndReturned(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return availabilityMapper.getFailDownData_OccurredAndReturned(queryPeriod);
	}

	@Override
	public List<FailDownData> getFailDownData_NotOccurredAndReturned(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return availabilityMapper.getFailDownData_NotOccurredAndReturned(queryPeriod);
	}

	@Override
	public List<FailDownData> getFailDownData_NotOccurredNotReturned(QueryPeriod queryPeriod) {
		// TODO Auto-generated method stub
		return availabilityMapper.getFailDownData_NotOccurredNotReturned(queryPeriod);
	}
	
	
	
}
