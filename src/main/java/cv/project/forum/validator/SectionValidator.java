package cv.project.forum.validator;

import cv.project.forum.entity.Section;
import cv.project.forum.service.SectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 * Validator for {@link cv.project.forum.entity.Section} class,
 * implements {@link Validator} interface.
 *
 * @author Georgii Zemlianyi
 * @version 1.0
 */

@Component
public class SectionValidator implements Validator {

    @Autowired
    SectionService sectionService;

    @Override
    public boolean supports(Class<?> aClass) {
        return Section.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        Section section = (Section) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "Required", "Это обязательное поле");

        if (sectionService.getSectionByName(section.getName()) != null) {
            errors.rejectValue("name", "Duplicate.sectionForm.name", "Такой раздел уже существует");
        }
    }
}
