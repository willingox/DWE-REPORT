package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.AvailabilityMapper;
import cn.xjfd.ssm.pojo.FailDownData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.AvailabilityService11111;
import cn.xjfd.ssm.service.AvailabilityService;
@Service
public class AvailabilityServiceImpl implements AvailabilityService{

	@Autowired
	AvailabilityMapper availabilityMapper;
	
	@Override
	public FailDownData getFailDownTime(QueryPeriod queryPeriod) {
		long failDownTime = 0;
		FailDownData failDownData = new FailDownData();
		failDownData.setId(queryPeriod.getId());
		int failDownData_OccurredNotReturned = availabilityMapper.getFailDownData_OccurredNotReturned(queryPeriod);
		
		if(failDownData_OccurredNotReturned >= 1) {
			failDownTime = queryPeriod.getEndTime().getTime() - queryPeriod.getStartTime().getTime();
			failDownData.setFailDownTime(failDownTime);
			return failDownData;
		}else {
			List<FailDownData> failDownData_OccurredAndReturned = availabilityMapper.getFailDownData_OccurredAndReturned(queryPeriod);
			if(failDownData_OccurredAndReturned != null && failDownData_OccurredAndReturned.size() != 0) {
				failDownTime += failDownData_OccurredAndReturned.get(0).getRemoveTime().getTime() - queryPeriod.getStartTime().getTime();
			}
			List<FailDownData> failDownData_NotOccurredAndReturned = availabilityMapper.getFailDownData_NotOccurredAndReturned(queryPeriod);
			if(failDownData_NotOccurredAndReturned != null && failDownData_NotOccurredAndReturned.size() !=0) {
				for (FailDownData failDownData2 : failDownData_NotOccurredAndReturned) {
					failDownTime += failDownData2.getRemoveTime().getTime() - failDownData2.getHappenTime().getTime();
				}
			}
			List<FailDownData> failDownData_NotOccurredNotReturned = availabilityMapper.getFailDownData_NotOccurredNotReturned(queryPeriod);
			if(failDownData_NotOccurredNotReturned != null && failDownData_NotOccurredNotReturned.size() != 0) {
				failDownTime += queryPeriod.getEndTime().getTime() - failDownData_NotOccurredNotReturned.get(0).getHappenTime().getTime();
			}
			failDownData.setFailDownTime(failDownTime);
			return failDownData;
		}
	}

}
