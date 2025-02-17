package com.car.rental.web;

import com.car.rental.asset.CarRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ViewController {

    CarRepository carRepository;

    ViewController(CarRepository carRepository) {
        this.carRepository = carRepository;
    }

    @RequestMapping("/car")
    public ModelAndView card(ModelAndView model) {
        model.setViewName("carlisting");
        model.addObject("cars", carRepository.findAll());
        return model;
    }

    @RequestMapping("/dashboard")
    public ModelAndView dashboard(ModelAndView model) {
        model.setViewName("dashboard");

        return model;
    }
}
