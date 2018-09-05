package cv.project.forum.repository;

import cv.project.forum.entity.Section;
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
public interface TopicRepository extends JpaRepository<Topic, Long> {

    @Query("SELECT t FROM Topic t ORDER BY t.views DESC")
    List<Topic> getTopicsSortedByViews();

    @Query("SELECT t FROM Topic t WHERE t.section=:section")
    Page<Topic> getTopicsForSection(@Param("section") Section section ,Pageable pageable);

    @Query("SELECT t FROM Topic t WHERE t.author=:author")
    Page<Topic> getTopicsForUser(@Param("author") User user, Pageable pageable);

    @Query("SELECT t FROM Topic t WHERE t.name LIKE :pattern")
    Page<Topic> searchTopics(@Param("pattern") String pattern, Pageable pageable);
}
