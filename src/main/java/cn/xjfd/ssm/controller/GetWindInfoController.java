package cn.xjfd.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.dao.GetWindNameMapper;
import cn.xjfd.ssm.pojo.WindGenerator;
import cn.xjfd.ssm.pojo.WindInfo;
import cn.xjfd.ssm.service.GetWindInfoService;
import cn.xjfd.ssm.service.GetWindNameService;

@RequestMapping("getWindInfoController")
@Controller
public class GetWindInfoController {

	@Autowired
	GetWindInfoService getWindInfoService;
	
	@ResponseBody
	@RequestMapping("getWindInfo")
	public List<WindInfo> getWindInfo() {
		// TODO Auto-generated method stub
		return getWindInfoService.getWindInfo();
	}
	
}