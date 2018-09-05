package cv.project.forum.service;


import cv.project.forum.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface UserService {
    User addUser(User user);

    User getUserByLogin(String login);

    boolean existsByLogin(String login);

    void updateUser(User user);

    User findOne(long id);

    void delete(User user);

    List<User> findAll();

    Page<User> findAll(Pageable pageable);
}
