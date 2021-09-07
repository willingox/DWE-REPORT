package cn.xjfd.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.ColumnData;
import cn.xjfd.ssm.service.GetOneMinColumnService;

@Controller
@RequestMapping("GetOneMinColumnController")
public class GetOneMinColumnController {

	@Autowired
	GetOneMinColumnService getOneMinColumnService;
	
	//重要量测测点
	@ResponseBody
	@RequestMapping("getOneMinColumn")
	public List<ColumnData> getOneMinColumn(){
		return getOneMinColumnService.getOneMinColumn();
	}
	
	//量测测点
	@ResponseBody
	@RequestMapping("getTenMinColumn")
	public List<ColumnData> getTenMinColumn(){
		return getOneMinColumnService.getTenMinColumn();
	}
	//统计信息测点
	@ResponseBody
	@RequestMapping("getOneDayColumn")
	public List<ColumnData> getOneDayColumn(){
		return getOneMinColumnService.getOneDayColumn();
	}
	
}
