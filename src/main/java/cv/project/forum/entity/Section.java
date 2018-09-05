package cv.project.forum.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "sections")
public class Section {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(nullable = false)
    private String name;

    @OneToMany(mappedBy = "section")
    private List<Topic> topicList = new ArrayList<>();

    public Section() {
    }

    public Section(String name) {
        this.name = name;
    }

    public void addTopic(Topic topic) {
        topic.setSection(this);
        topicList.add(topic);
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setTopicList(List<Topic> topicList) {
        this.topicList = topicList;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public List<Topic> getTopicList() {
        return topicList;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Section section = (Section) o;

        return id == section.id;
    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }
}
