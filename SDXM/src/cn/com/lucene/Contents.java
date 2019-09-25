package cn.com.lucene;

import java.io.Serializable;

import org.springframework.stereotype.Repository;

@Repository
public class Contents implements Serializable{

	private static final long serialVersionUID = 4135989835434090319L;

	private String id;
	
	private String type;
	
	private String title;
	
	private String content;

	private String enable;

	public String getKey() {
		return type + '_' + id;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content == null ? "" : content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getEnable() {
		return enable;
	}

	public void setEnable(String enable) {
		this.enable = enable;
	}
}