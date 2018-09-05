package cv.project.forum.service;


import cv.project.forum.entity.Section;
import cv.project.forum.entity.Topic;
import cv.project.forum.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;

import java.util.List;

public interface TopicService {
    Topic addTopic(Topic topic);

    List<Topic> getAllTopics();

    List<Topic> getTopicsSortedByViews();

    Topic getTopicById(long id);

    Topic update(Topic topic);

    Page<Topic> getTopicsForSection(Section section, Pageable pageable);

    Page<Topic> getTopicsForUser(User user, Pageable pageable);

    void delete(Topic topic);

    Page<Topic> getAllTopics(Pageable pageable);

    Page<Topic> searchTopics(String pattern, Pageable pageable);

}
