package cv.project.forum.service.impl;

import cv.project.forum.entity.Section;
import cv.project.forum.repository.SectionRepository;
import cv.project.forum.service.SectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DBSectionService implements SectionService{

    @Autowired
    private SectionRepository sectionRepository;

    @Override
    @Transactional
    public List<Section> getAllSections() {
        return sectionRepository.findAll();
    }

    @Override
    @Transactional
    public Section getSectionById(Long id) {
        return sectionRepository.findOne(id);
    }

    @Override
    @Transactional
    public Section getSectionByName(String name) {
        return sectionRepository.getSectionByName(name);
    }

    @Override
    @Transactional
    public Section addSection(Section section) {
        return sectionRepository.saveAndFlush(section);
    }
}
