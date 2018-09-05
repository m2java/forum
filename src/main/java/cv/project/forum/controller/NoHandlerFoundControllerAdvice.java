package cv.project.forum.controller;


import cv.project.forum.exception.ElementNotFoundException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class NoHandlerFoundControllerAdvice {

    @ExceptionHandler(NoHandlerFoundException.class)
    public String handleNoHandlerFoundException(NoHandlerFoundException ex) {
        return "error";
    }

    @ExceptionHandler(ElementNotFoundException.class)
    public String handleNotFoundException() {
        return "error";
    }
}
