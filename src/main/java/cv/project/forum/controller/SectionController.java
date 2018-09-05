package cv.project.forum.controller;

import cv.project.forum.entity.Section;
import cv.project.forum.service.SectionService;
import cv.project.forum.validator.SectionValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
public class SectionController {

    @Autowired
    private SectionValidator sectionValidator;

    @Autowired
    private SectionService sectionService;

    @RequestMapping(value = "/newsection", method = RequestMethod.GET)
    String newSection(Model model) {
        model.addAttribute("sectionForm", new Section());

        return "newsection";
    }

    @RequestMapping(value = "/newsection", method = RequestMethod.POST)
    public String createUser(@ModelAttribute("sectionForm") Section sectionForm,
                             BindingResult bindingResult) {

        sectionValidator.validate(sectionForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "newsection";
        }

        Section section = new Section(sectionForm.getName());
        sectionService.addSection(section);

        return "redirect:/";
    }
}
