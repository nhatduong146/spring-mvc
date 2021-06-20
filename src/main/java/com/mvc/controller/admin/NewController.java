package com.mvc.controller.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mvc.dto.NewDTO;
import com.mvc.service.ICategoryService;
import com.mvc.service.INewService;
import com.mvc.utils.MessageUtil;

@Controller(value = "newControllerOfAdmin")
public class NewController {
	
	@Autowired
	private INewService newService;
	
	@Autowired
	private ICategoryService categoryService;
	
	@Autowired
	private MessageUtil messageUtil;

	@RequestMapping(value = "/admin/new/list", method = RequestMethod.GET)
	public ModelAndView showList(@RequestParam("page") Integer page, 
									@RequestParam("limit") Integer limit, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/new/list");
		NewDTO model = new NewDTO();
		Pageable pageable = new PageRequest(page-1, limit);
		
		model.setLimit(limit);
		model.setPage(page);
		model.setListResult(newService.findAll(pageable));
		model.setTotalItem(newService.getTotalItem());
		model.setTotalPage((int) Math.ceil((double) model.getTotalItem() / model.getLimit()));
		mav.addObject("model", model);
		
		if(request.getParameter("message") != null) {
			String message = request.getParameter("message");
			mav.addObject("alert", messageUtil.getAlert(message));
			mav.addObject("message", message);
		}
		
		return mav;
	}
	
	@RequestMapping(value = {"/admin/new/add", "/admin/new/edit"}, method = RequestMethod.GET)
	public ModelAndView editNew(@RequestParam(value = "id", required = false) Long id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/new/edit");
		NewDTO newDTO = new NewDTO();
		Map<String, String> categories = categoryService.findAll();
		
		if(id != null) {
			newDTO = newService.findById(id);
		}
		mav.addObject("model", newDTO);
		mav.addObject("categories", categories);
		
		if(request.getParameter("message") != null) {
			String message = request.getParameter("message");
			mav.addObject("alert", messageUtil.getAlert(message));
			mav.addObject("message", message);
		}
		
		return mav;
	}
}
