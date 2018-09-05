package cv.project.forum.util;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;

public class SiteUser extends User {
    private long id;
    private String avatarHash;

    public SiteUser(String username, String password, Collection<? extends GrantedAuthority> authorities, long id, String avatarHash) {
        super(username, password, authorities);
        this.id = id;
        this.avatarHash = avatarHash;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getAvatarHash() {
        return avatarHash;
    }

    public void setAvatarHash(String avatarHash) {
        this.avatarHash = avatarHash;
    }
}
