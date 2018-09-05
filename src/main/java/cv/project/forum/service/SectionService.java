package cv.project.forum.service;


import cv.project.forum.entity.Section;

import java.util.List;

public interface SectionService {
    List<Section> getAllSections();

    Section getSectionById(Long id);

    Section getSectionByName(String name);

    Section addSection(Section section);

}
