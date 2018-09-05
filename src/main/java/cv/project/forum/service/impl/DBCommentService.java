package cv.project.forum.service.impl;

import cv.project.forum.entity.Comment;
import cv.project.forum.entity.Topic;
import cv.project.forum.entity.User;
import cv.project.forum.repository.CommentRepository;
import cv.project.forum.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DBCommentService implements CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Override
    @Transactional
    public List<Comment> getAllComments() {
        return commentRepository.findAll();
    }

    @Override
    @Transactional
    public Page<Comment> getCommentsForTopic(Topic topic, Pageable pageable) {
        return commentRepository.getCommentsForTopic(topic, pageable);
    }

    @Override
    @Transactional
    public Page<Comment> getCommentsForUser(User user, Pageable pageable) {
        return commentRepository.getCommentsForUser(user, pageable);
    }

    @Override
    @Transactional
    public Comment addComment(Comment comment) {
        return commentRepository.saveAndFlush(comment);
    }

    @Override
    @Transactional
    public Comment getCommentById(long id) {
        return commentRepository.findOne(id);
    }

    @Override
    @Transactional
    public void updateComment(Comment comment) {
        commentRepository.saveAndFlush(comment);
    }

    @Override
    @Transactional
    public void deleteComment(Comment comment) {
        commentRepository.delete(comment);
    }

    @Override
    @Transactional
    public Page<Comment> findAll(Pageable pageable) {
        return commentRepository.findAll(pageable);
    }

    @Override
    @Transactional
    public List<Comment> getLastComments() {
        return commentRepository.findTop10ByOrderByDateTimeDesc();
    }

}
