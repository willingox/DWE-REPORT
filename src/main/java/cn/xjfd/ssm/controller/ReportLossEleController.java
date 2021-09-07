package cn.xjfd.ssm.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.DateParameter;
import cn.xjfd.ssm.pojo.EffectiveHoursData;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportLossEleData;
import cn.xjfd.ssm.service.ReportLossEleService;
import cn.xjfd.ssm.util.DataAccuracy;
import cn.xjfd.ssm.util.DateFormatting;

@Controller
@RequestMapping("ReportLossEleController")
public class ReportLossEleController {

	@Autowired
	ReportLossEleService reportLossEleService;

	@ResponseBody
	@RequestMapping(value = "getReportLossEle", method = RequestMethod.POST)
	public List<ReportLossEleData> getReportLossEle(@RequestParam("startTime") String startTimeStr,@RequestParam("endTime") String endTimeStr, @RequestParam("gids") int[] gids) throws ParseException {
		List<ReportLossEleData> reportLossEleData = new ArrayList<ReportLossEleData>();
		DateParameter date = DateFormatting.dateFormatting(startTimeStr, endTimeStr);
		QueryPeriod queryPeriod = new QueryPeriod();
		queryPeriod.setStartTime(date.getStartTime());
		queryPeriod.setEndTime(date.getEndTime());
		queryPeriod.setYear(date.getStartYear());
		queryPeriod.setGids(gids);
		reportLossEleData = reportLossEleService.getReportLossEle(queryPeriod);
		for (int i = 0; i < reportLossEleData.size(); i++) {
			reportLossEleData.get(i).setGridErrStopHour(DataAccuracy.keepThree(reportLossEleData.get(i).getGridErrStopHour()));
			reportLossEleData.get(i).setWeaErrStopHour(DataAccuracy.keepThree(reportLossEleData.get(i).getWeaErrStopHour()));
			reportLossEleData.get(i).sethMIStopHour(DataAccuracy.keepThree(reportLossEleData.get(i).gethMIStopHour()));
			reportLossEleData.get(i).setRemoteStopHour(DataAccuracy.keepThree(reportLossEleData.get(i).getRemoteStopHour()));
			reportLossEleData.get(i).setErrBreakHour(DataAccuracy.keepThree(reportLossEleData.get(i).getErrBreakHour()));
			reportLossEleData.get(i).setPowLimHour(DataAccuracy.keepThree(reportLossEleData.get(i).getPowLimHour()));
			reportLossEleData.get(i).setGridErrPowSum(DataAccuracy.keepThree(reportLossEleData.get(i).getGridErrPowSum()));
			reportLossEleData.get(i).setWeaErrPowSum(DataAccuracy.keepThree(reportLossEleData.get(i).getWeaErrPowSum()));
			reportLossEleData.get(i).sethMIStopPowSum(DataAccuracy.keepThree(reportLossEleData.get(i).gethMIStopPowSum()));
			reportLossEleData.get(i).setRemoteStopPowSum(DataAccuracy.keepThree(reportLossEleData.get(i).getRemoteStopPowSum()));
			reportLossEleData.get(i).setErrBreakPowSum(DataAccuracy.keepThree(reportLossEleData.get(i).getErrBreakPowSum()));
			reportLossEleData.get(i).setPowLimPowSum(DataAccuracy.keepThree(reportLossEleData.get(i).getPowLimPowSum()));
			reportLossEleData.get(i).setHiddenPow(DataAccuracy.keepThree(reportLossEleData.get(i).getHiddenPow()));
			reportLossEleData.get(i).setCapAva(DataAccuracy.keepThree(reportLossEleData.get(i).getCapAva()));
			reportLossEleData.get(i).setAvaHours(DataAccuracy.keepThree(reportLossEleData.get(i).getAvaHours()));
			reportLossEleData.get(i).setHoursSum(DataAccuracy.keepThree(reportLossEleData.get(i).getHoursSum()));
			reportLossEleData.get(i).setLossGenSum(DataAccuracy.keepThree(reportLossEleData.get(i).getLossGenSum()));
		}
		return reportLossEleData;
	
		
	}

}
