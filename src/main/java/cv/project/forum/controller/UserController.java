package cv.project.forum.controller;

import cv.project.forum.entity.Comment;
import cv.project.forum.entity.Topic;
import cv.project.forum.entity.User;
import cv.project.forum.entity.enums.UserRole;
import cv.project.forum.exception.ElementNotFoundException;
import cv.project.forum.service.CommentService;
import cv.project.forum.service.TopicService;
import cv.project.forum.service.UserService;
import cv.project.forum.util.MD5Util;
import cv.project.forum.util.SiteUser;
import cv.project.forum.validator.NewPasswordValidator;
import cv.project.forum.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;


/**
 * Controller for {@link User}'s pages.
 *
 * @version 1.0
 * @Author Georgii Zemlianyi
 */


@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private TopicService topicService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private NewPasswordValidator newPasswordValidator;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm,
                               BindingResult bindingResult) {

        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        ShaPasswordEncoder encoder = new ShaPasswordEncoder();
        String passHash = encoder.encodePassword(userForm.getConfirmPassword(), null);

        userForm.setPassword(passHash);
        userForm.setRole(UserRole.USER);
        String avatarHash = MD5Util.md5Hex(userForm.getLogin());
        userForm.setAvatarHash(avatarHash);
        userService.addUser(userForm);

        return "redirect:/";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, String error) {
        if (error != null) {
            model.addAttribute("error", "Имя пользовател или пароль некорректны");
        }

        return "login";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout() {
        return "redirect:/";
    }

    @RequestMapping(value = "/users/{user_login}", method = RequestMethod.GET)
    public String onUser(@PathVariable("user_login") String login,
                         @AuthenticationPrincipal SiteUser siteUser, Model model) {
        User user = userService.getUserByLogin(login);
        if (user == null) {
            throw new ElementNotFoundException();
        }

        model.addAttribute("user", user);
        model.addAttribute("title", calculateTitle(user));

        if (siteUser == null || !(login.equals(siteUser.getUsername()))) {
            return "user";
        } else {
            return "profile";
        }
    }

    @RequestMapping(value = "/users")
    public String users(@PageableDefault(
            size = 20) Pageable pageable, Model model) {

        Page<User> page = userService.findAll(pageable);
        model.addAttribute("page", page);

        return "users";
    }

    @RequestMapping(value = "/users/{user_login}/comments", method = RequestMethod.GET)
    public String userTopics(@PathVariable("user_login") String login,
                             @PageableDefault(size = 20,direction = Sort.Direction.DESC,sort ="dateTime" )Pageable pageable,
                             Model model) {
        User user = userService.getUserByLogin(login);

        if (user == null) {
            throw new ElementNotFoundException();
        }

        Page<Comment> page = commentService.getCommentsForUser(user, pageable);

        model.addAttribute("user", user);
        model.addAttribute("page", page);

        return "userComments";
    }

    @RequestMapping(value = "/users/{user_login}/topics", method = RequestMethod.GET)
    public String userComments(@PathVariable("user_login") String login,
                               @PageableDefault(size=20, direction = Sort.Direction.DESC, sort="dateTime") Pageable pageable,
                               Model model) {
        User user = userService.getUserByLogin(login);

        if (user == null) {
            throw new ElementNotFoundException();
        }

        Page<Topic> page = topicService.getTopicsForUser(user, pageable);

        model.addAttribute("user", user);
        model.addAttribute("page", page);

        return "userTopics";
    }

    @RequestMapping(value = "/users/{user_login}/update", method = RequestMethod.GET)
    public String userUpdate(@AuthenticationPrincipal SiteUser siteUser,
                             @PathVariable("user_login") String login, Model model) {
        User user = userService.getUserByLogin(login);

        if (user == null) {
            throw new ElementNotFoundException();
        }
        if (siteUser == null || !(login.equals(siteUser.getUsername()))) {
            throw new ElementNotFoundException();
        }
        model.addAttribute("userForm", new User());
        model.addAttribute("login", login);

        return "userUpdate";
    }

    @RequestMapping(value = "/users/{user_login}/update", method = RequestMethod.POST)
    public String userUpdate(@PathVariable("user_login") String login, @ModelAttribute("userForm") User userForm,
                             @AuthenticationPrincipal SiteUser siteUser, BindingResult bindingResult) {
        User user = userService.getUserByLogin(login);

        if (user == null) {
            throw new ElementNotFoundException();
        }
        if (siteUser == null || !(login.equals(siteUser.getUsername()))) {
            throw new ElementNotFoundException();
        }
        userForm.setLogin(login);
        newPasswordValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "userUpdate";
        }
        ShaPasswordEncoder encoder = new ShaPasswordEncoder();
        String passHash = encoder.encodePassword(userForm.getConfirmPassword(), null);

        user.setPassword(passHash);
        userService.updateUser(user);

        return "redirect:/";
    }

    @RequestMapping(value = "/users/{user_login}/delete", method = RequestMethod.POST)
    public String userDelete(@PathVariable("user_login") String login, @AuthenticationPrincipal SiteUser siteUser) {
        User user = userService.getUserByLogin(login);

        if (user == null) {
            throw new ElementNotFoundException();
        }
        if (siteUser == null || !(login.equals(siteUser.getUsername()))) {
            throw new ElementNotFoundException();
        }

        userService.delete(user);

        return "redirect:/logout";
    }

    private String calculateTitle(User user) {
        switch (user.getRole()) {
            default:
                return "Новичок";
        }
    }

}
