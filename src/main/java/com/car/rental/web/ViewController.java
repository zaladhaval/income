package com.car.rental.web;

import com.car.rental.car.CarRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
public class ViewController {

    CarRepository carRepository;

    ViewController(CarRepository carRepository) {
        this.carRepository = carRepository;
    }

    @RequestMapping("/carview")
    public ModelAndView card(ModelAndView model) {
        model.setViewName("cars");
        return model;
    }

    @RequestMapping("/dashboard")
    public ModelAndView dashboard(ModelAndView model) {
        model.setViewName("dashboard");

        return model;
    }
}
