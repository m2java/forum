package cv.project.forum.controller;

import cv.project.forum.entity.User;
import cv.project.forum.entity.enums.UserRole;
import cv.project.forum.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * Controller class handling requests on "/".
 *
 * @author Georgii Zemlianyi
 * @version 1.0
 */


@Controller
public class AdminController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String onAdmin(@PageableDefault(size = 20) Pageable pageable, Model model) {

        Page<User> page = userService.findAll(pageable);
        model.addAttribute("page", page);

        return "admin";
    }

    @RequestMapping(value = "/admin/update/{user_login}", method = RequestMethod.POST)
    public String onAdmin(@PathVariable("user_login") String login,
                          @RequestParam("role") String role, Model model) {

        User user = userService.getUserByLogin(login);

        UserRole userRole = UserRole.USER;
        if (role.equals("admin")) {
            userRole = UserRole.ADMIN;
        } else {
            if (role.equals("moderator")) {
                userRole = UserRole.MODERATOR;
            }
        }
        user.setRole(userRole);

        userService.updateUser(user);

        return "redirect:/admin";
    }

}
