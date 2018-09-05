package cv.project.forum.sevice.impl;

import cv.project.forum.entity.User;
import cv.project.forum.repository.UserRepository;
import cv.project.forum.service.UserService;
import cv.project.forum.service.impl.DBUserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class DBUserServiceTest {

    @InjectMocks
    private UserService userService = new DBUserService();

    @Mock
    private UserRepository userRepository;

    @Test
    public void testAddUser() throws Exception {
        User expectedUser = new User();
        when(userRepository.saveAndFlush(any(User.class))).thenReturn(expectedUser);
        User actualUser = userService.addUser(expectedUser );
        assertEquals(expectedUser, actualUser);
    }

    @Test
    public void testGetByLogin() throws Exception {
        User expectedUser = new User();
        when(userRepository.findByLogin(any(String.class))).thenReturn(expectedUser);
        User actualUser = userService.getUserByLogin("");
        assertEquals(expectedUser, actualUser);
    }
}
