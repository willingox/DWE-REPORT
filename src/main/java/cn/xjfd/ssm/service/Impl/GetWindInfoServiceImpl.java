package cn.xjfd.ssm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.xjfd.ssm.dao.GetWindInfoMapper;
import cn.xjfd.ssm.pojo.WindInfo;
import cn.xjfd.ssm.service.GetWindInfoService;
@Service
public class GetWindInfoServiceImpl implements GetWindInfoService{

	@Autowired
	GetWindInfoMapper getWindInfoMapper;

	@Override
	public List<WindInfo> getWindInfo() {
		// TODO Auto-generated method stub
		return getWindInfoMapper.getWindInfo();
	}
	


	
}
