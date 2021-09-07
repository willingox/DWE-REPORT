package cn.xjfd.ssm.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.SingleMaxPowerData;
import cn.xjfd.ssm.service.SingleMaxPowerDataService;
import cn.xjfd.ssm.util.DataAccuracy;

@Controller
@RequestMapping("SingleMaxPowerDataController")
public class SingleMaxPowerDataController {

	@Autowired
	SingleMaxPowerDataService singleMaxPowerDataService;
	
	@ResponseBody
	@RequestMapping(value = "getSingleMaxPowerData", method = RequestMethod.POST)
	public List<SingleMaxPowerData> getSingleMaxPowerData(@RequestParam("startTime") String startTimeStr,@RequestParam("endTime") String endTimeStr) throws ParseException{
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String startyear = startTimeStr.substring(0, 4);
		String endyear = endTimeStr.substring(0, 4);
		int startyearint = Integer.parseInt(startyear);
		int endyearint = Integer.parseInt(endyear);
		int yearCount = endyearint - startyearint;
		Date startTime = sdf.parse(startTimeStr);
		Date endTime = sdf.parse(endTimeStr);
		
		List<Integer> ids = singleMaxPowerDataService.getWindId();
		List<SingleMaxPowerData> singleMaxPowerDatas = new ArrayList<SingleMaxPowerData>();
		
		if(yearCount == 0) {
			QueryPeriod queryPeriod = new QueryPeriod();
			queryPeriod.setStartTime(startTime);
			queryPeriod.setEndTime(endTime);
			queryPeriod.setYear(startyearint);
			for (Integer id : ids) {
//				System.out.println(id);
				
				queryPeriod.setId(id);
				SingleMaxPowerData data = new SingleMaxPowerData();
				
//				System.out.println(queryPeriod);
				data = (SingleMaxPowerData)singleMaxPowerDataService.getSMaxPowerData(queryPeriod);
				data.setMaxCurp(DataAccuracy.keepThree(data.getMaxCurp()));
				data.setMaxWind(DataAccuracy.keepThree(data.getMaxWind()));
				singleMaxPowerDatas.add(data);
			}
			return singleMaxPowerDatas;
		}else if(yearCount == 1) {
			QueryPeriod queryPeriod1 = new QueryPeriod();
			List<SingleMaxPowerData> datas1 = new ArrayList<SingleMaxPowerData>();
			queryPeriod1.setStartTime(startTime);
			queryPeriod1.setEndTime(endTime);
			queryPeriod1.setYear(startyearint);
			for (Integer id : ids) {
				queryPeriod1.setId(id);
				SingleMaxPowerData data = new SingleMaxPowerData();
				data = (SingleMaxPowerData) singleMaxPowerDataService.getSMaxPowerData(queryPeriod1);
				data.setMaxCurp(DataAccuracy.keepThree(data.getMaxCurp()));
				data.setMaxWind(DataAccuracy.keepThree(data.getMaxWind()));
				datas1.add(data);
			}
			
			QueryPeriod queryPeriod2 = new QueryPeriod();
			List<SingleMaxPowerData> datas2 = new ArrayList<SingleMaxPowerData>();
			queryPeriod2.setStartTime(startTime);
			queryPeriod2.setEndTime(endTime);
			queryPeriod2.setYear(endyearint);
			for (Integer id : ids) {
				queryPeriod2.setId(id);
				SingleMaxPowerData data = new SingleMaxPowerData();
				data = (SingleMaxPowerData) singleMaxPowerDataService.getSMaxPowerData(queryPeriod2);
				data.setMaxCurp(DataAccuracy.keepThree(data.getMaxCurp()));
				data.setMaxWind(DataAccuracy.keepThree(data.getMaxWind()));
				datas2.add(data);
			}
			
			for (int i = 0; i < datas2.size(); i++) {
				double maxCurp2 = datas2.get(i).getMaxCurp();
				for (int j = 0; j < datas1.size(); j++) {
					
					if(datas2.get(i).getId() == datas1.get(j).getId()) {
						double maxCurp1 = datas1.get(j).getMaxCurp();
//						System.out.println(datas2.get(i).getId());
//						System.out.println(datas1.get(j).getId());
						if(maxCurp1 > maxCurp2) {
//							System.out.println(maxCurp1);
//							System.out.println(maxCurp2);
							datas2.get(i).setMaxCurp(datas1.get(j).getMaxCurp());
							datas2.get(i).setMaxTime(datas1.get(j).getMaxTime());
							datas2.get(i).setMaxWind(datas1.get(j).getMaxWind());
//							System.out.println(datas2.get(i).getMaxCurp());
						}
					}
				}
			}
//			System.out.println(datas2);
			return datas2;
		}
		
		return singleMaxPowerDatas;
	}
}
