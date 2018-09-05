package cv.project.forum.service.impl;

import cv.project.forum.entity.Section;
import cv.project.forum.entity.Topic;
import cv.project.forum.entity.User;
import cv.project.forum.repository.TopicRepository;
import cv.project.forum.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DBTopicService implements TopicService {

    @Autowired
    private TopicRepository topicRepository;

    @Override
    @Transactional
    public Topic addTopic(Topic topic) {
        return topicRepository.saveAndFlush(topic);
    }

    @Override
    @Transactional
    public List<Topic> getAllTopics() {
        return topicRepository.findAll();
    }

    @Override
    @Transactional
    public List<Topic> getTopicsSortedByViews() {
        return topicRepository.getTopicsSortedByViews();
    }

    @Override
    @Transactional
    public Topic getTopicById(long id) {
        return topicRepository.findOne(id);
    }

    @Override
    @Transactional
    public Topic update(Topic topic) {
        return topicRepository.saveAndFlush(topic);
    }

    @Override
    @Transactional
    public Page<Topic> getTopicsForSection(Section section,Pageable pageable) {
        return topicRepository.getTopicsForSection(section, pageable);
    }

    @Override
    @Transactional
    public Page<Topic> getTopicsForUser(User user, Pageable pageable) {
        return topicRepository.getTopicsForUser(user, pageable);
    }

    @Override
    @Transactional
    public void delete(Topic topic) {
        topicRepository.delete(topic);
    }

    @Override
    @Transactional
    public Page<Topic> getAllTopics(Pageable pageable) {
        return topicRepository.findAll(pageable);
    }

    @Override
    @Transactional
    public Page<Topic> searchTopics(String pattern, Pageable pageable) {
        return topicRepository.searchTopics(pattern, pageable);
    }
}
