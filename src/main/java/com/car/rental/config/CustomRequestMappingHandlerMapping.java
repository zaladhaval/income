package com.car.rental.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.AnnotatedElementUtils;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import java.lang.reflect.Method;
import java.util.stream.Collectors;

@Configuration
public class CustomRequestMappingHandlerMapping extends RequestMappingHandlerMapping {

    private static final String API_PREFIX = "/api";

    @Override
    protected void registerHandlerMethod(Object handler, Method method, RequestMappingInfo mapping) {
        Class<?> beanType = method.getDeclaringClass();

        // Check if the class is annotated with @RestController
        if (AnnotatedElementUtils.hasAnnotation(beanType, RestController.class)) {
            RequestMappingInfo newMapping = RequestMappingInfo.paths(prependApiPrefix(mapping))
                    .methods(mapping.getMethodsCondition().getMethods().toArray(new RequestMethod[0]))
                    .params(mapping.getParamsCondition().getExpressions().toArray(new String[0]))
                    .headers(mapping.getHeadersCondition().getExpressions().toArray(new String[0]))
                    .consumes(mapping.getConsumesCondition().getExpressions().toArray(new String[0]))
                    .produces(mapping.getProducesCondition().getExpressions().toArray(new String[0])).build();

            super.registerHandlerMethod(handler, method, newMapping);
        } else {
            super.registerHandlerMethod(handler, method, mapping);
        }
    }

    private String[] prependApiPrefix(RequestMappingInfo mapping) {
        return mapping.getPathPatternsCondition().getPatterns().stream()
                .map(pattern -> API_PREFIX + pattern.getPatternString())  // Manually add "/api"
                .collect(Collectors.toSet()).toArray(new String[0]);
    }
}



