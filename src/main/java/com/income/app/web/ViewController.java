package com.income.app.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ViewController {

  @Autowired
  ItemService itemService;

  @RequestMapping("/view-items")
  public ModelAndView viewBooks(ModelAndView model) {
    model.setViewName("alerts");
    model.addObject("items", itemService.getAll());
    return model;
  }
}
