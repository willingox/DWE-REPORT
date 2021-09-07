package cn.xjfd.ssm.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.xjfd.ssm.pojo.User;
import cn.xjfd.ssm.service.UserService;

@Controller
public class PageController {
	@Resource
	private UserService userService;
	/**
	 * 登陆页面
	 * @param username
	 * @param password
	 * @param request
	 * @return
	 */
	@RequestMapping("/")
	public String showIndex() {
		return "login";
	}

	@RequestMapping("/{page}")
	public String showPage(@PathVariable String page) {
		return page;
	}
/**
 * 登录表单提交功能
 * @param username
 * @param password
 * @param request
 * @return
 */
	@RequestMapping(value="/login", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> login(@RequestParam(value = "username", required = true) String username,
			@RequestParam(value = "password", required = true) String password, HttpServletRequest request) {
		Map<String, String> ret = new HashMap<String, String>();
//		System.out.println(username);
//		System.out.println(password);
		if (StringUtils.isEmpty(username)) {
			ret.put("type", "error");
			ret.put("msg", "用户名不能为空!");
			return ret;
		}
		if (StringUtils.isEmpty(password)) {
			ret.put("type", "error");
			ret.put("msg", "密码不能为空!");
			return ret;
		}
		User user = userService.getLogin(username);
//		System.out.println(user.getUsername());
//		System.out.println(user.getPassword());
		if (user == null) {
			ret.put("type", "error");
			ret.put("msg", "不存在该用户!");
			return ret;
		}
		if (!password.equals(user.getUSER_PASSWORD())) {
			ret.put("type", "error");
			ret.put("msg", "密码错误!");
			return ret;
		}
		request.getSession().setAttribute("user", user);
//		request.getSession().setMaxInactiveInterval(10);
		ret.put("type", "success");
		ret.put("msg", "登录成功!");
		return ret;
	}
	
	/**
	 * 注销登录
	 * @param username
	 * @param password
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/login_out", method = RequestMethod.GET)
	public String loginOut(HttpServletRequest request) {
		request.getSession().setAttribute("user", null);
		return "redirect:login";
	}
}
