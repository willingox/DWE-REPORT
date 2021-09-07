package cn.xjfd.ssm.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.GenerationPageData;
import cn.xjfd.ssm.pojo.PowerCurveActual;
import cn.xjfd.ssm.pojo.PowerCurveData;
import cn.xjfd.ssm.pojo.PowerCurveStandard;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.service.PowerCurveService;
import cn.xjfd.ssm.util.DataAccuracy;

@RequestMapping("PowerCurveController")
@Controller
public class PowerCurveController {

	@Autowired
	PowerCurveService powerCurveService;

	
	@ResponseBody
	@RequestMapping(value = "getPowerCurveData" ,method = RequestMethod.POST)
	public List<PowerCurveData> getPowerCurveData(@RequestParam("startTime") String startTimeStr,@RequestParam("endTime") String endTimeStr,@RequestParam("id") int id) throws ParseException {
		QueryPeriod queryPeriod = new QueryPeriod();
		queryPeriod.setId(id);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String startyear = startTimeStr.substring(0, 4);
		String endyear = endTimeStr.substring(0, 4);
		int startyearint = Integer.parseInt(startyear);
		int endyearint = Integer.parseInt(endyear);
		int yearCount = endyearint - startyearint;
		List<PowerCurveData> PowerCurveDatas = new ArrayList<PowerCurveData>();
		List<PowerCurveStandard> data1 = powerCurveService.getPowerCurveStandard(queryPeriod);
		if(yearCount == 0) {
			Date startTime = sdf.parse(startTimeStr);
			Date endTime = sdf.parse(endTimeStr);
			queryPeriod.setYear(startyearint);
			queryPeriod.setStartTime(startTime);
			queryPeriod.setEndTime(endTime);
			
			
			List<PowerCurveActual> data2 = powerCurveService.getPowerCurveActual(queryPeriod);
			for (int i = 0; i < data1.size(); i++) {
				String wind = data1.get(i).getWindvelval();
				float windf = Float.parseFloat(wind);
				PowerCurveData powerData = new PowerCurveData();
				powerData.setWindvelval(wind);
				powerData.setGenpwd(data1.get(i).getGenpwd());
				powerData.setCurp(data1.get(i).getGenpwd());
								
				for (int j = 0; j < data2.size(); j++) {
					String wind2 = data2.get(j).getWindvelval();
					float windf2 = Float.parseFloat(wind2);
					if (Math.abs(windf*2 - windf2) < 0.0001) {
						powerData.setCurp(DataAccuracy.keepThree(data2.get(j).getCurp()));
					}
				}
				PowerCurveDatas.add(i, powerData);
			}
			return PowerCurveDatas;
		}else if(yearCount == 1) {
			Date startTime = sdf.parse(startTimeStr);
			Date endTimeTemp = sdf.parse(startyear + "-12-31 23:59:59");
			QueryPeriod queryPeriod1 = new QueryPeriod();
			queryPeriod1.setYear(startyearint);
			queryPeriod1.setStartTime(startTime);
			queryPeriod1.setEndTime(endTimeTemp);
			queryPeriod1.setId(id);
			List<PowerCurveActual> data21 = powerCurveService.getPowerCurveActual(queryPeriod1);
			
			
			Date startTimeTemp = sdf.parse(endyear + "-01-01 00:00:00");
			Date endTime = sdf.parse(endTimeStr);
			QueryPeriod queryPeriod2 = new QueryPeriod();
			queryPeriod2.setYear(endyearint);
			queryPeriod2.setStartTime(startTimeTemp);
			queryPeriod2.setEndTime(endTime);
			queryPeriod2.setId(id);
			List<PowerCurveActual> data22 = powerCurveService.getPowerCurveActual(queryPeriod2);
			for (int i = 0; i < data22.size(); i++) {
				String wind = data22.get(i).getWindvelval();
				float windf = Float.parseFloat(wind);
				
				for (int j = 0; j < data21.size(); j++) {
					String wind2 = data21.get(j).getWindvelval();
					float windf2 = Float.parseFloat(wind2);
					
					if (Math.abs(windf - windf2) < 0.0001) {
//						System.out.println(windf);
//						System.out.println(windf2);
//						System.out.println(windf*2);
//						System.out.println(windf*2 - windf2);
						double curp22 = data22.get(i).getCurp();
//						System.out.println(curp22);
						double curp21 = data21.get(j).getCurp();
//						System.out.println(curp21);
						double curpavg = (curp22 + curp21)/2;
//						curpavg = DataAccuracy.keepThree(curpavg);
//						System.out.println(curpavg);
//						String curp = String.valueOf(curpavg);
						data22.get(i).setCurp(curpavg);
					}
				}
			}
			
			for (int i = 0; i < data1.size(); i++) {
				String wind = data1.get(i).getWindvelval();
				float windf = Float.parseFloat(wind);
				PowerCurveData powerData = new PowerCurveData();
				powerData.setWindvelval(wind);
				powerData.setGenpwd(data1.get(i).getGenpwd());
				powerData.setCurp(data1.get(i).getGenpwd());
				
				for (int j = 0; j < data22.size(); j++) {
					String wind2 = data22.get(j).getWindvelval();
					float windf2 = Float.parseFloat(wind2);
					if (Math.abs(windf*2 - windf2) < 0.0001) {
						powerData.setCurp(DataAccuracy.keepThree(data22.get(j).getCurp()));
					}
				}
				PowerCurveDatas.add(i, powerData);
			}
			return PowerCurveDatas;
		}
		
		

		
		
		return PowerCurveDatas;
	}
	
}
