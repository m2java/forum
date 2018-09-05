package cv.project.forum.validator;


import cv.project.forum.entity.User;
import cv.project.forum.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 * Validator for {@link cv.project.forum.entity.User} class,
 * implements {@link Validator} interface.
 *
 * @author Georgii Zemlianyi
 * @version 1.0
 */


@Component
public class UserValidator implements Validator {

    @Autowired
    private UserService userService;

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "login", "Required", "Это обязательное поле");

        if (user.getLogin().length() < 6 || user.getLogin().length() > 32) {
            errors.rejectValue("login", "Size.userForm.login", "Логин должне быть длинее 6 символов");
        }

        if (!user.getLogin().matches("^[A-Za-z0-9]+$")) {
            errors.rejectValue("login", "Latin.userForm.login", "Логин должне содержать только латинские символы");
        }

        if (userService.getUserByLogin(user.getLogin()) != null) {
            errors.rejectValue("login", "Duplicate.userForm.login", "Такой логин уже существует");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "Required", "Это обязательное поле");

        if (user.getPassword().length() < 6 || user.getPassword().length() > 32) {
            errors.rejectValue("password", "Size.userFrom.password", "Пароль должне быть длинее 6 символов");
        }

        if (!user.getConfirmPassword().equals(user.getPassword())) {
            errors.rejectValue("confirmPassword", "Different.userForm.password", "Введите корректный пароль при подтверждении");
        }

    }
}
