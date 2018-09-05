package cv.project.forum.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "topics")
public class Topic {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column
    private String name;

    @Column(columnDefinition = "text")
    private String text;

    @Column(name = "date_time", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateTime;

    @ManyToOne
    @JoinColumn(name = "author_id", nullable = false)
    private User author;

    @ManyToOne
    @JoinColumn(name = "section_id", nullable = false)
    private Section section;

    @Column(name = "views", columnDefinition = "int(11) default '0'")
    private int views;

    @OneToMany(mappedBy = "topic", orphanRemoval = true)
    private List<Comment> commentsList = new ArrayList<>();

    public Topic(String name, String text, Date dateTime, User author, Section section) {
        this.name = name;
        this.text = text;
        this.dateTime = dateTime;
        this.author = author;
        this.section = section;
    }

    public Topic() {
    }

    public void addComment(Comment comment) {
        comment.setTopic(this);
        commentsList.add(comment);
    }

    public void incrementViews() {
        views++;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
    public Date getDateTime() {
        return dateTime;
    }

    public User getAuthor() {
        return author;
    }

    public Section getSection() {
        return section;
    }

    public int getViews() {
        return views;
    }

    public List<Comment> getCommentsList() {
        return commentsList;
    }

    public void setSection(Section section) {
        this.section = section;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Topic topic = (Topic) o;

        return id == topic.id;
    }

    @Override
    public int hashCode() {
        return (int) (id ^ (id >>> 32));
    }
}

