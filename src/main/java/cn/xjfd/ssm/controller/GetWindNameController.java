package cn.xjfd.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.dao.GetWindNameMapper;
import cn.xjfd.ssm.pojo.WindGenerator;
import cn.xjfd.ssm.service.GetWindNameService;

@RequestMapping("getWindNameController")
@Controller
public class GetWindNameController {

	@Autowired
	GetWindNameService getWindNameService;
	
	@ResponseBody
	@RequestMapping("getWindName")
	public List<WindGenerator> getWindName(){
		
		
		return getWindNameService.getWindName();
	}
	
}
