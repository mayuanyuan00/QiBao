package cn.com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("tt")
public class TakaController {

	@RequestMapping("gopage")
	public String gotopage(String page){
		return "website/"+page;
	}
	
	@RequestMapping("gopage2")
	public @ResponseBody String gotopage2(String page){
		return "website/"+page;
	}
	
	
}
