package cv.project.forum.repository;

import cv.project.forum.entity.Comment;
import cv.project.forum.entity.Topic;
import cv.project.forum.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    @Query("SELECT c FROM Comment c WHERE c.topic=:topic")
    Page<Comment> getCommentsForTopic(@Param("topic") Topic topic,Pageable pageable);

    @Query("SELECT c FROM Comment c WHERE c.author=:author")
    Page<Comment> getCommentsForUser(@Param("author") User user, Pageable pageable);

    List<Comment> findTop10ByOrderByDateTimeDesc();
}
