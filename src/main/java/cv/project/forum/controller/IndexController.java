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
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


/**
 * Controller class handling requests on "/".
 *
 * @author Georgii Zemlianyi
 * @version 1.0
 */

@Controller
public class IndexController {

    @Autowired
    private TopicService topicService;

    @Autowired
    private SectionService sectionService;

    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(@PageableDefault(
            size = 20,
            direction = Sort.Direction.DESC,
            sort = "views") Pageable pageable, Model model) {

        Page<Topic> page = topicService.getAllTopics(pageable);

        //-1 for correlation of pageable.getPageNumber() and page.getTotalPages()
        if (pageable.getPageNumber() > page.getTotalPages() - 1 || pageable.getPageNumber() < 0) {
            throw new ElementNotFoundException();
        }
        List<Section> allSections = sectionService.getAllSections();
        List<Comment> lastComments = commentService.getLastComments();

        model.addAttribute("page", page);
        model.addAttribute("sections", allSections);
        model.addAttribute("comments", lastComments);
        return "index";
    }

    @RequestMapping(value = "/section/{section_id}", method = RequestMethod.GET)
    public String onSection(@PathVariable("section_id") long id,
                            @PageableDefault(size = 20, direction = Sort.Direction.DESC,
                                    sort = "views") Pageable pageable, Model model) {
        Section section = sectionService.getSectionById(id);
        Page<Topic> page = topicService.getTopicsForSection(section, pageable);
        List<Section> allSections = sectionService.getAllSections();

        model.addAttribute("page", page);
        model.addAttribute("sections", allSections);

        return "index";
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String onSearch(@RequestParam("text") String text,
                           @PageableDefault(size = 20,
                                   direction = Sort.Direction.DESC,
                                   sort = "views") Pageable pageable, Model model) {
        String safeText = Jsoup.clean(text, Whitelist.relaxed());
        String pattern = "%" + safeText + "%";

        model.addAttribute("page", topicService.searchTopics(pattern, pageable));
        model.addAttribute("text", text);
        return "search";
    }

}