package cv.project.forum.controller;

import cv.project.forum.entity.Comment;
import cv.project.forum.entity.Section;
import cv.project.forum.entity.Topic;
import cv.project.forum.entity.User;
import cv.project.forum.exception.ElementNotFoundException;
import cv.project.forum.service.CommentService;
import cv.project.forum.service.SectionService;
import cv.project.forum.service.TopicService;
import cv.project.forum.service.UserService;
import cv.project.forum.util.SiteUser;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;

@Controller
public class TopicController {

    @Autowired
    UserService userService;

    @Autowired
    TopicService topicService;

    @Autowired
    SectionService sectionService;

    @Autowired
    CommentService commentService;

    @RequestMapping(value = "/newtopic", method = RequestMethod.GET)
    public String newTopic(Model model) {
        List<Section> sections = sectionService.getAllSections();
        for (Section s : sections) {
            System.out.println(s.getName());
        }
        model.addAttribute("sections", sections);

        return "newtopic";
    }

    @RequestMapping(value = "/newtopic", method = RequestMethod.POST)
    public String createTopic(@AuthenticationPrincipal SiteUser siteUser,
                              @RequestParam("topicname") String topicName,
                              @RequestParam("text") String text,
                              @RequestParam("sectionname") String sectionName) {

        String login = siteUser.getUsername();
        User user = userService.getUserByLogin(login);
        if (login == null) {
            throw new ElementNotFoundException();
        }

        Long sectionId = Long.parseLong(sectionName);
        Section section = sectionService.getSectionById(sectionId);
        String safeText = Jsoup.clean(text, Whitelist.relaxed());
        Topic topicToPersist = new Topic(topicName, safeText, new Date(), user, section);
        topicService.addTopic(topicToPersist);

        return "redirect:/";
    }

    @RequestMapping(value = "/topic/{topic_id}", method = RequestMethod.GET)
    public String onTopic(@PathVariable("topic_id") long id,
                          @PageableDefault(size = 20, direction = Sort.Direction.ASC, sort = "dateTime") Pageable pageable,
                          Model model) {
        Topic topic = topicService.getTopicById(id);
        topic.incrementViews();
        Topic updatedTopic = topicService.update(topic);
        Page<Comment> page = commentService.getCommentsForTopic(updatedTopic, pageable);

        model.addAttribute("topic", updatedTopic);
        model.addAttribute("page", page);

        return "topic";
    }

    @RequestMapping(value = "/topic/{topic_id}/comments", method = RequestMethod.POST)
    public String onComment(@AuthenticationPrincipal SiteUser siteUser,
                            @PathVariable("topic_id") long id,
                            @RequestParam String text,
                            @PageableDefault(size = 20, direction = Sort.Direction.ASC, sort = "dateTime") Pageable pageable,
                            Model model) {
        String login = siteUser.getUsername();
        if (login == null) {
            throw new ElementNotFoundException();
        }
        User user = userService.getUserByLogin(login);
        Topic topic = topicService.getTopicById(id);
        Comment comment = new Comment(text, user, topic, new Date());

        commentService.addComment(comment);
        Page<Comment> page = commentService.getCommentsForTopic(topic, pageable);

        model.addAttribute("topic", topic);
        model.addAttribute("page", page);
        return "topic";
    }

    @RequestMapping(value = "/topic/{topic_id}/comments", method = RequestMethod.GET)
    public String onComment(@PathVariable("topic_id") long id) {
        return "redirect: /topic/" + id;
    }

    @RequestMapping(value = "/topic/{topic_id}/update", method = RequestMethod.GET)
    public String topicUpdate(@PathVariable("topic_id") long id,
                              @AuthenticationPrincipal SiteUser siteUser, Model model) {

        String login = siteUser.getUsername();
        User user = userService.getUserByLogin(login);
        if (user == null) {
            throw new ElementNotFoundException();
        }
        Topic topic = topicService.getTopicById(id);
        if (topic == null) {
            throw new ElementNotFoundException();
        }
        List<Section> sections = sectionService.getAllSections();
        Section topicSection = topic.getSection();
        sections.remove(topicSection);

        if (topic.getAuthor().getId() == user.getId()) {
            model.addAttribute("topic", topic);
            model.addAttribute("sections", sections);
            model.addAttribute("topicSection", topicSection);

            return "topicUpdate";
        } else {
            throw new ElementNotFoundException();
        }
    }

    @RequestMapping(value = "/topic/{topic_id}/update", method = RequestMethod.POST)
    public String topicDelete(@PathVariable("topic_id") long id, @AuthenticationPrincipal SiteUser siteUser,
                              @RequestParam("topicname") String topicName, @RequestParam("text") String text,
                              @RequestParam("sectionId") long sectionId) {

        String login = siteUser.getUsername();
        User user = userService.getUserByLogin(login);
        Topic topic = topicService.getTopicById(id);

        if (topic == null || !(topic.getAuthor().getId() == user.getId())) {
            throw new ElementNotFoundException();
        }

        Section section = sectionService.getSectionById(sectionId);
        topic.setSection(section);
        topic.setName(topicName);
        topic.setText(text);
        topicService.update(topic);

        return "redirect:/topic/" + id;
    }

    @RequestMapping(value = "/topic/{topic_id}/delete", method = RequestMethod.POST)
    public String topicDelete(@PathVariable("topic_id") long id, @AuthenticationPrincipal SiteUser siteUser) {

        String login = siteUser.getUsername();
        User user = userService.getUserByLogin(login);
        Topic topic = topicService.getTopicById(id);
        if (user == null) {
            throw new ElementNotFoundException();
        }
        if (topic == null || !(topic.getAuthor().getId() == user.getId())) {
            throw new ElementNotFoundException();
        }

        topicService.delete(topic);

        return "redirect:/users/" + login + "/topics";
    }

    @RequestMapping(value = "/topic/{topic_id}/comment/{comment_id}/update", method = RequestMethod.GET)
    public String commentUpdate(@PathVariable("topic_id") long topicId, @PathVariable("comment_id") long commentId,
                                @AuthenticationPrincipal SiteUser siteUser, Model model) {

        String login = siteUser.getUsername();
        User user = userService.getUserByLogin(login);
        Topic topic = topicService.getTopicById(topicId);
        if (topic == null) {
            throw new ElementNotFoundException();
        }

        Comment comment = commentService.getCommentById(commentId);
        if (comment == null || !(comment.getAuthor().getId() == user.getId())) {
            throw new ElementNotFoundException();
        }

        model.addAttribute("topic", topic);
        model.addAttribute("comment", comment);

        return "commentUpdate";
    }

    @RequestMapping(value = "/topic/{topic_id}/comment/{comment_id}/update", method = RequestMethod.POST)
    public String commentUpdate(@PathVariable("topic_id") long topicId, @PathVariable("comment_id") long commentId,
                                @RequestParam String text, @AuthenticationPrincipal SiteUser siteUser,
                                @PageableDefault(size = 20, direction = Sort.Direction.ASC, sort = "dateTime") Pageable pageable,
                                Model model) {

        String login = siteUser.getUsername();
        if (login == null) {
            throw new ElementNotFoundException();
        }
        User user = userService.getUserByLogin(login);
        Comment comment = commentService.getCommentById(commentId);
        if (comment == null || !(comment.getAuthor().getId() == user.getId())) {
            throw new ElementNotFoundException();
        }

        Topic topic = topicService.getTopicById(topicId);
        comment.setText(text);
        commentService.updateComment(comment);
        Page<Comment> page = commentService.getCommentsForTopic(topic, pageable);

        model.addAttribute("topic", topic);
        model.addAttribute("page", page);

        return "redirect:/topic/" + topicId;
    }

    @RequestMapping(value = "/topic/{topic_id}/comment/{comment_id}/delete", method = RequestMethod.POST)
    public String commentDelete(@PathVariable("topic_id") long topicId, @PathVariable("comment_id") long commentId,
                                @AuthenticationPrincipal SiteUser siteUser) {

        String login = siteUser.getUsername();
        if (login == null) {
            throw new ElementNotFoundException();
        }
        User user = userService.getUserByLogin(login);
        Comment comment = commentService.getCommentById(commentId);
        if (comment == null || !(comment.getAuthor().getId() == user.getId())) {
            throw new ElementNotFoundException();
        }

        commentService.deleteComment(comment);
        return "redirect:/topic/" + topicId;
    }

    @RequestMapping(value = "/comments")
    public String onComments(@PageableDefault(size = 20) Pageable pageable, Model model) {

        Page<Comment> page = commentService.findAll(pageable);
        model.addAttribute("page", page);
        return "comments";
    }

}


