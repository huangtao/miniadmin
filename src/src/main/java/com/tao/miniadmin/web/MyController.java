package com.tao.miniadmin.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyController {
	
	@RequestMapping("/test")
	public String test(Model model) {
		model.addAttribute("msg", "标准变量表达式");
		
		return "test";
	}
}

