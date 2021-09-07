package cn.xjfd.ssm.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.xjfd.ssm.dao.AvailabilityMapper;
import cn.xjfd.ssm.pojo.FailDownData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.AvailabilityService11111;

public class test {

	@Autowired
	static
	AvailabilityService11111 availabilityService;
	
	public static void main(String[] args){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date startTime;
		Date endTime;
		QueryPeriod queryPeriod = new QueryPeriod();
		try {
			startTime = sdf.parse("2019-01-01 00:00:00");
			endTime = sdf.parse("2019-12-01 00:00:00");
			
			queryPeriod.setStartTime(startTime);
			queryPeriod.setEndTime(endTime);
			queryPeriod.setYear(2019);
			queryPeriod.setId(3);
			System.out.println(queryPeriod);
			int data4 = availabilityService.getFailDownData_OccurredNotReturned(queryPeriod);
			System.out.println(data4);
//			List<FailDownData> data1 = new ArrayList<FailDownData>();
//			data1 = availabilityMapper.getFailDownData_NotOccurredAndReturned(queryPeriod);
//			System.out.println(data1);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
//		List<FailDownData> data2 = availabilityMapper.getFailDownData_NotOccurredNotReturned(queryPeriod);
//		List<FailDownData> data3 = availabilityMapper.getFailDownData_OccurredAndReturned(queryPeriod);
//		int data4 = availabilityMapper.getFailDownData_OccurredNotReturned(queryPeriod);
	}
	
	
	
	

}
