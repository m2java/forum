package cv.project.forum.service;

import cv.project.forum.entity.Comment;
import cv.project.forum.entity.Topic;
import cv.project.forum.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface CommentService {
    List<Comment> getAllComments();

    Page<Comment> getCommentsForTopic(Topic topic,Pageable pageable);

    Page<Comment> getCommentsForUser(User user, Pageable pageable);

    Comment addComment(Comment comment);

    Comment getCommentById(long id);

    void updateComment(Comment comment);

    void deleteComment(Comment comment);

    Page<Comment> findAll(Pageable pageable);

    List<Comment> getLastComments();
}
