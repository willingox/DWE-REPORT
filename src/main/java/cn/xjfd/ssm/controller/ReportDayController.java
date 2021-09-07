package cn.xjfd.ssm.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.DateParameter;
import cn.xjfd.ssm.pojo.QueryPeriod;
import cn.xjfd.ssm.pojo.ReportData;
import cn.xjfd.ssm.pojo.ReportDayData;
import cn.xjfd.ssm.service.ReportDayService;
import cn.xjfd.ssm.util.DataAccuracy;
import cn.xjfd.ssm.util.DateFormatting;
import cn.xjfd.ssm.util.GetSpecifiedDayBefore;

@Controller
@RequestMapping("ReportDayController")
public class ReportDayController {

	@Autowired
	ReportDayService reportDayService;
	
	@ResponseBody
	@RequestMapping(value = "getReportDay", method = RequestMethod.POST)
	public List<ReportDayData> getReportDay(@RequestParam("startTime") String startTimeStr) throws ParseException{
		
		List<ReportDayData> reportDayData = new ArrayList<ReportDayData>();
		DateParameter dateParameter = DateFormatting.dateFormatting(startTimeStr);
		
		QueryPeriod queryPeriod = new QueryPeriod();
		queryPeriod.setStartTime(dateParameter.getStartTime());
		queryPeriod.setYear(dateParameter.getStartYear());
		reportDayData = reportDayService.getReportDay(queryPeriod);
		
		
		QueryPeriod yesterdayQueryPeriod = new QueryPeriod();
		String yesterdayStartDay = GetSpecifiedDayBefore.getSpecifiedDayBefore(startTimeStr);
		DateParameter dateParameterYesterday = DateFormatting.dateFormatting(yesterdayStartDay);
		yesterdayQueryPeriod.setStartTime(dateParameterYesterday.getStartTime());
		yesterdayQueryPeriod.setYear(dateParameterYesterday.getStartYear());
		List<ReportDayData> yesterdayData = new ArrayList<ReportDayData>();
		yesterdayData = reportDayService.getReportDayYesterday(yesterdayQueryPeriod);
		
		for (int i = 0; i < reportDayData.size(); i++) {
			ReportDayData idata = reportDayData.get(i);
			for (int j = 0; j < yesterdayData.size(); j++) {
				ReportDayData jdata = yesterdayData.get(j);
				if (idata.getId() == jdata.getId()) {
					reportDayData.get(i).setLftHour(DataAccuracy.keepThree(idata.getLftHour() - jdata.getLftHour()));
					reportDayData.get(i).setRtghHour(DataAccuracy.keepThree(idata.getRtghHour() - jdata.getRtghHour()));
					reportDayData.get(i).setYawHour(DataAccuracy.keepThree(idata.getYawHour() - jdata.getYawHour()));
					reportDayData.get(i).setLftYawMotorCWCou(idata.getLftYawMotorCWCou() - jdata.getLftYawMotorCWCou());
					reportDayData.get(i).setRtghYawMotorCCWCou(idata.getRtghYawMotorCCWCou() - jdata.getRtghYawMotorCCWCou());
					reportDayData.get(i).setYawCWCou(idata.getYawCWCou() - jdata.getYawCWCou());
					reportDayData.get(i).setWinTurStCovCont(idata.getWinTurStCovCont() - jdata.getWinTurStCovCont());
					reportDayData.get(i).setSerModTimes(idata.getSerModTimes() - jdata.getSerModTimes());
					reportDayData.get(i).setWinTurErrCovCont(idata.getWinTurErrCovCont() - jdata.getWinTurErrCovCont());
					reportDayData.get(i).setConvMaiSwitchCou(idata.getConvMaiSwitchCou() - jdata.getConvMaiSwitchCou());
					reportDayData.get(i).setWinHigErrTimes(idata.getWinHigErrTimes() - jdata.getWinHigErrTimes());
					reportDayData.get(i).setWinTurCatInCont(idata.getWinTurCatInCont() - jdata.getWinTurCatInCont());
					reportDayData.get(i).setWinTurArtStpCont(idata.getWinTurArtStpCont() - jdata.getWinTurArtStpCont());
				}
			}
			
		}

		return reportDayData;
	}
}
